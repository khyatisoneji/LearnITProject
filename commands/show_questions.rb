class ShowQuestions < SlackRubyBot::Commands::Base
  def self.call(client, data, match)
    team = client.owner
    questions = Question.where(team: team)
    if questions.empty?
      client.say(channel: data.channel, text: ["There are no questions added currently"])
    end
    text = "```\n"
    text << "QuestionID QuestionText\n"
    questions.each do |question|
      text << "#{question.id} #{question.question}\n"
    end
    text << "To answer the question, check answerQuestion command in help\n"
    client.say(channel: data.channel, text: [text<<  "```"])
  end
end
