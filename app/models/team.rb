class Team
  has_many :users
  has_many :questions
  has_one :question_schedule
  def team_id
    self.slack_team_id
  end
end
