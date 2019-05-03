class Answer < ApplicationRecord
  belongs_to :question

  def self.answer_question(client, question_id, answer)
    question = Question.where(team: client.owner, id: question_id).first

    if !question.present?
      raise "No question found for the questionID: #{question_id}"
    end

    instance ||= Answer.create!(question: question, answer: answer)
    instance
  end
end
