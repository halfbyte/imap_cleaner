A quick hack to clean up messy IMAP inboxes.

# Dependencies

- Ruby 2.3 (because the MOVE command was introduced in the 2.3 stdlib)

# Install

- unpack/clone it to a folder of your choosing
- copy config.examle.yml to config.yml and edit the config file

# Run

    $ ruby imap_cleaner.rb

# Configuration

The filter language should be relatively self explanatory. The key/value pairs in search allow you
to build IMAP search strings. Yes, currently it's not possible to use OR or other constructs that
need more than one argument.

Additionally, you can specify a max_age in days, so that only messages that are older than, say
30 days are modified

Actions are a set of actions that will be applied to all matching messages. Currently only move is
implemented, as this is the only thing I need. (Most Email clients unfortunately don't understand
the correct deletion sematics of IMAP...)
