class SendQuestions < Que::Job
  def run(args)
    ActiveRecord::Base.transaction do
      user = User.find(args[:user_id])
      questions = Question.where(team_id: user.team_id)
      team = Team.where(slack_team_id: args[:team_id]).first
      client = Slack::Web::Client.new(token: team.token)

      #create text to send to user
      text = "Hey #{user.nickname} Answer the below questions.\n"
      questions.each_with_index do |question, i|
        text += "Question Number: " + (i + 1).to_s
        text = text + "\nQuestion ID: " + question.id.to_s
        text = text + "\nQuestion: " + question.question + "\n"
      end
      text += "\n\nTo answer these questions:\n Use the following command:\n answerQuestion <question id listed above> <your answer for the question> \n"

      #post message in slack
      message = {
          text: text,
          channel: args[:channel],
          as_user: true
      }
      client.chat_postMessage(message)

      #create a new job for tomorrow
      question_time = QuestionScheduleTime.where(team: team).first
      SendQuestions.enqueue user_id: user.id, team_id: team.slack_team_id, channel: args[:channel], run_at: QuestionScheduleTime.next_timestamp(question_time.question_time, user.timezone)
      destroy
    end
  end
end
