class User < ApplicationRecord
  belongs_to :team

  def self.slack_mention?(user_name)
    ::Regexp.last_match[1] if user_name =~ /^<@(.*)>$/
  end

  def self.find_by_slack_mention!(client, user_name)
    slack_id = slack_mention?(user_name)
    unless slack_id
      raise "Please enter valid user handle"
    end
    user = find_create_or_update_by_slack_id!(client, slack_id, user_name)
    raise "I don't know who #{user_name} is!" unless user
    user
  end

  def self.find_create_or_update_by_slack_id!(client, slack_id, nickname)
    instance = User.where(team: client.owner, slack_user_id: slack_id).first
    if instance
      raise "User #{nickname} already exists"
    end
    instance_info = Hashie::Mash.new(client.web_client.users_info(user: slack_id)).user
    if instance_info.is_bot
      raise "User #{nickname} is a bot, cannot add a bot"
    end
    instance.update_attributes!(user_name: instance_info.name) if instance && instance.user_name != instance_info.name
    instance ||= User.create!(team: client.owner, slack_user_id: slack_id, user_name: instance_info.name, nickname: nickname, timezone: instance_info.tz)
    instance
  end
end
