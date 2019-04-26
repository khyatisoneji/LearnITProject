class SendQuestions < Que::Job
  def run(user_id)
    ActiveRecord::Base.transaction do
      user = User.find(user_id)
      questions = Question.where(team_id: user.team_id)
      # client.say(channel: data.channel, text: ["Answer the below questions"].join("\n"))
      questions.each do |question|
        puts question.question
        # client.say(channel: data.channel, text: [question.question].join("\n"))
      end
      destroy
    end
  end
end
