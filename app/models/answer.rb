class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  def self.answer_question(client, question_id, answer, user)
    user_inst = User.where(slack_user_id: user).first
    question = Question.where(team: client.owner, id: question_id).first

    if !question.present?
      raise "No question found for the questionID: #{question_id}"
    end
    instance ||= Answer.create!(question: question, answer: answer, user: user_inst)
    instance
  end
end
