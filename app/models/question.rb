class Question < ApplicationRecord
  belongs_to :team
  has_many :answers
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
    t = DateTime
    id = t.now.strftime("%Y%m%d%k%M%S%L") # Get current date to the milliseconds
    id = id.to_i.to_s(36) # will generate somthing like "5i0sp1h4tkc"

    # Reverse it
    self.id = id.to_i(36)
  end
end
