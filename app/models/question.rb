class Question < ApplicationRecord
  belongs_to :team
  def self.find_create_or_update_by_question!(client, question)
    instance = Question.where(team: client.owner, question: question).first
    if instance
      raise "Question #{question} already exists"
    end
    instance ||= Question.create!(team: client.owner, question: question)
    instance
  end
end
