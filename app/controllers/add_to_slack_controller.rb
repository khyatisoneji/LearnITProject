require 'net/http'

class AddToSlackController < ActionController::API
  def main
    params do
      requires :code, type: String
      optional :state, type: String
    end

    client = Slack::Web::Client.new
    rc = client.oauth_access(
        client_id: Figaro.env.SLACK_CLIENT_ID,
        client_secret: Figaro.env.SLACK_CLIENT_SECRET,
        code: params['code']
    )
    token = rc['bot']['bot_access_token']
    bot_user_id = rc['bot']['bot_user_id']
    user_id = rc['user_id']
    access_token = rc['access_token']
    team = Team.where(token: token).first
    team ||= Team.where(team_id: rc['team_id']).first

    if team
      team.update_attributes!(
          activated_user_id: user_id,
          activated_user_access_token: access_token,
          bot_user_id: bot_user_id
      )
      raise "Team #{team.name} is already registered." if team.active?
      team.activate!(token)
    else
      team = Team.create!(
          token: token,
          team_id: rc['team_id'],
          name: rc['team_name'],
          activated_user_id: user_id,
          activated_user_access_token: access_token,
          bot_user_id: bot_user_id
      )
    end
    render json: { message: 'Team Successfully Registered' }, status: 200
  end
end
