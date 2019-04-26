class Question < ApplicationRecord
  belongs_to :team
  before_create :generate_random_id

  def self.find_create_or_update_by_question!(client, question)
    instance = Question.where(team: client.owner, question: question).first
    if instance
      raise "Question #{question} already exists"
    end
    instance ||= Question.create!(team: client.owner, question: question)
    instance
  end

  private
  def generate_random_id
    self.id = SecureRandom.uuid
  end
end
