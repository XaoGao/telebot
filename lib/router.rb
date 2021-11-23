# frozen_string_literal: true

class Router
  attr_reader :bot, :routes

  def initialize(bot, routes)
    @bot = bot
    @routes = routes
  end

  def resolve(message)
    user = FindUserService.new.find message
    CommandFactory.new(bot, message, user).create_command(routes).call
  rescue StandardError => e
    Log.error e.message
    Log.error e.backtrace
  end
end
