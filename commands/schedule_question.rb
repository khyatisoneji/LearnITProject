class ScheduleQuestion < SlackRubyBot::Commands::Base
  def self.call(client, data, match)
    time = match['expression']
    team = client.owner
    question_time = QuestionScheduleTime::find_create_or_update_by_team!(team, time)
    client.say(channel: data.channel, text: ["Successfully scheduled the session for team #{team.name} daily at time: #{question_time.question_time}"].join("\n"))
    logger.info "Scheduled questions for team: #{client.owner} at time=#{question_time.question_time}"
  end
end
