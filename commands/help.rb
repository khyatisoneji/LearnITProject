class Help < SlackRubyBot::Commands::Base
  HELP = <<-EOS.freeze
```
Following commands are available:
General
-------
help               - get this helpful message
addUser <user> ... - add users who will be asked questions
addQuestion <question> - add question to be asked
scheduleQuestion <time> - Time required in HH:mm format. schedule all questions daily at provided time
showQuestions - Shows the list of questions that the user has to answer
answerQuestion <questionID> <answer> -Question id should be the one asked in the question. Answer can be anything 
downloadReport - Download the report containing all user answers
```
  EOS
  def self.call(client, data, _match)
    client.say(channel: data.channel, text: [HELP].join("\n"))
    logger.info "HELP: #{client.owner}, user=#{data.user}"
  end
end
