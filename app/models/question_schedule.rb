class QuestionScheduleTime < ApplicationRecord
  belongs_to :team

  def self.find_create_or_update_by_team!(team, schedule_time)
    instance ||= QuestionScheduleTime.create!(team: team, question_time: schedule_time)
    instance
  end

  def self.event_time(time_str)
    t = DateTime.strptime(time_str, "%H:%M").to_time
    t >= Time.now ? t : t + 24*60*60
  end

  def self.next_timestamp(question_time, timezone)
    today_hour_x = DateTime.parse(question_time).change(:offset => Time.now.in_time_zone(timezone).formatted_offset).to_time
    timestamp = today_hour_x + (today_hour_x - DateTime.now().in_time_zone(timezone).to_time > 0 ? 0 : 24*60*60)
    return timestamp
  end
end
