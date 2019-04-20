require 'pry'

class Help < SlackRubyBot::Commands::Base
  HELP = <<-EOS.freeze
```
Following commands are available:
General
-------
help               - get this helpful message
```
  EOS
  def self.call(client, data, _match)
    binding.pry
    client.say(channel: data.channel, text: [HELP].join("\n"))
    logger.info "HELP: #{client.owner}, user=#{data.user}"
  end
end
