class AddUser < SlackRubyBot::Commands::Base
  def self.call(client, data, match)
    arguments = match['expression'].split.reject(&:blank?) if match['expression']
    arguments ||= []
    arguments.each do |user_name|
      user = User::find_by_slack_mention!(client, user_name)
      client.say(channel: data.channel, text: ["Successfully added #{user.nickname}"].join("\n"))
      logger.info "Added user to team: #{client.owner}, user=#{user}"
    end
  end
end
