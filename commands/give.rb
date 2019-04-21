require 'pry'

class Give < SlackRubyBot::Commands::Base
  def self.call(client, data, match)
    binding.pry
    arguments = match['expression'].split.reject(&:blank?) if match['expression']
    arguments ||= []
    logger.info arguments
    arguments.each do |user_name|
      user = User::find_by_slack_mention!(client, user_name)
      puts user
      logger.info "HELP: #{client.owner}, user=#{data.user}"
    end
  end
end
