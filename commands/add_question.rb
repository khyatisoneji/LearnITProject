class AddQuestion < SlackRubyBot::Commands::Base
  def self.call(client, data, match)
    question = match['expression']
    added_question = Question::find_create_or_update_by_question!(client, question)
    client.say(channel: data.channel, text: ["Successfully added question: #{added_question.question}"].join("\n"))
    logger.info "Added question to team: #{client.owner}, question=#{question}"
  end
end
