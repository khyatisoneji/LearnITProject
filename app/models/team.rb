class Team
  has_many :users
  has_many :questions
  def team_id
    self.slack_team_id
  end
end
