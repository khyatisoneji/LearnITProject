class Help < SlackRubyBot::Commands::Base
  HELP = <<-EOS.freeze
```
Following commands are available:
General
-------
help               - get this helpful message
set question time <time> - set time to ask question, input time in HH:mm format(example: 22:30)
give <user> ... - add users who will be asked questions
```
  EOS
  def self.call(client, data, _match)
    client.say(channel: data.channel, text: [HELP].join("\n"))
    logger.info "HELP: #{client.owner}, user=#{data.user}"
  end
end
