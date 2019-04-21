class Team < ApplicationRecord
  has_many :users
  has_many :questions
  def self.users
    binding.pry
    User.where(team_id: self.id)
  end
end
