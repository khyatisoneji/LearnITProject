class AnswerQuestion < SlackRubyBot::Commands::Base
  def self.call(client, data, match)
    arguments = match['expression'].split(' ', 2).reject(&:blank?) if match['expression']
    arguments ||= []

    question_id = arguments[0]
    answer = arguments[1]

    Answer::answer_question(client, question_id, answer)
    client.say(channel: data.channel, text: ["Successfully answered question"].join("\n"))
    logger.info "User answered to question: #{question_id} in team: #{client.owner}"
  end
end
