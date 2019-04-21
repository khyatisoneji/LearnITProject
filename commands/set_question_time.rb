class AddQuestion < SlackRubyBot::Commands::Base
  def self.call(client, data, _match)
    client.say(channel: data.channel, text: [HELP].join("\n"))
    logger.info "HELP: #{client.owner}, user=#{data.user}"
  end
end
