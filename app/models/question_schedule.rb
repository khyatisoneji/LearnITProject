class QuestionScheduleTime < ApplicationRecord
  belongs_to :team

  def self.find_create_or_update_by_team!(team, schedule_time)
    instance ||= QuestionScheduleTime.create!(team: team, question_time: schedule_time)
    instance
  end
end
