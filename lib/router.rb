# frozen_string_literal: true

module Telebot
  class Router
    attr_reader :command_factory

    def initialize(bot, routes)
      @command_factory = CommandFactory.new(bot, routes)
    end

    def resolve(message)
      user = FindUserService.new.find message
      command_factory.create_command(user, message).call
    rescue StandardError => e
      Log.error e.message
      Log.error e.backtrace
    end
  end
end
