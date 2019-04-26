# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
require_relative 'commands'
require_relative 'models'
require_relative 'jobs'
require 'slack-ruby-bot-server'
require 'que'

Thread.new do
  SlackRubyBotServer::App.instance.prepare!
  SlackRubyBotServer::Service.start!
  Que.mode = :async
  run SlackRubyBotServer::Api::Middleware.instance
end


run Rails.application
