class DownloadReport < SlackRubyBot::Commands::Base
  def self.call(client, data, match)
    team = client.owner
    users = User.where(team: team)
    questions = Question.where(team: team)
    text = "```"
    users.each do |user|
      text << "User Name: #{user.user_name}\n\n"
      questions.each do |question|
        text << "Question: #{question.question}\n"
        answer = Answer.where(user: user, question: question).first
        text << "Answer Time: #{answer.created_at}\n"
        text << "User's Answer: #{answer.answer}\n\n"
      end
    end
    client.say(channel: data.channel, text: [text <<  "```"])
  end
end
