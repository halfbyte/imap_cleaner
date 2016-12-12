require 'net/imap'
require 'yaml'

config = YAML.load_file('config.yml')

imap = Net::IMAP.new(config['account']['server'], ssl: config['account']['ssl'])

imap.authenticate('PLAIN', config['account']['login'], config['account']['password'])
imap.examine('INBOX')

def search_list(fc)
  list = []
  fc['search'].each do |key, value|
    list << key.upcase
    list << value
  end
  if fc['max_age']
    latest = Date.today - fc['max_age'].to_i
    list << 'BEFORE'
    list << Net::IMAP.format_date(latest)
    list
  end
end

config['filters'].each do |filter_config|
  puts "applying #{filter_config['name']}"
  ids = imap.search(search_list(filter_config))
  next if ids.length == 0
  filter_config['actions'].each do |action|
    action.each do |k, v|
      if k == 'move'
        puts "Moving #{ids.length} messages to #{v}"
        imap.move(ids, "INBOX/#{v}")
      else
        puts "Not implemented: #{k}: #{v}"
      end
    end
  end
end
