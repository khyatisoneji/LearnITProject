# LearnITProject Slack bot

This slack bot can be used to ask questions to user.
The slack bot figures out the timezone of the user and asks them question by taking into account their timezone.

## Commands Supported:
a. Help: Get list of commands available

b. Add User: Add user to ask questions

c. Add Question: Add question to be asked to all users

d. Schedule Question: Set the time in HH:mm format when the answer will be scheduled

e. Download report: This report contains information of each answer provided by users.

f. Show Questions: Shows the questions that the user has to answer

## Starting the application:
This application is written in Ruby on Rails.

First copy the sample application config to your application config by runnning command:

`cp config/application.yml.sample config/application.yml`

You need to add postgres login credentials and slack details like `slack client id` and `slack client secret`

To run the application run the command:
`bundle exec rails s -p 4567`

To run migrations:
`rake db:migrate`

## How to add this slack bot to your slack workspace
Open index.html file on your web browser, click on Add to slack button and it will ask you to add this bot to your slack workspace.
