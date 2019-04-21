require 'pry'
class User < ApplicationRecord
  belongs_to :team

  def self.slack_mention?(user_name)
    ::Regexp.last_match[1] if user_name =~ /^<@(.*)>$/
  end

  def self.find_by_slack_mention!(client, user_name)
    team = client.owner
    slack_id = slack_mention?(user_name)
    binding.pry
    user = if slack_id
             team.users.where(user_id: slack_id).first
           else
             regexp = ::Regexp.new("^#{user_name}$", 'i')
             User.where(team: team).or({ user_name: regexp }, nickname: regexp).first
           end
    binding.pry
    unless user
      begin
        binding.pry
        users_info = client.web_client.users_info(user: slack_id || "@#{user_name}")
        info = Hashie::Mash.new(users_info).user if users_info
        user = User.create!(team: team, user_id: info.id, user_name: info.name, registered: true) if info
      rescue Slack::Web::Api::Errors::SlackError => e
        raise e unless e.message == 'user_not_found'
      end
    end
    raise SlackGamebot::Error, "I don't know who #{user_name} is! Ask them to _register_." unless user&.registered?
    raise SlackGamebot::Error, "I don't know who #{user_name} is!" unless user

    user
  end
end
