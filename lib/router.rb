# frozen_string_literal: true

module Telebot
  class Router
    attr_reader :command_factory

    def initialize(bot, routes)
      raise ArgumentError, "Set Telebot::Settings.routes!" if routes.nil?

      @command_factory = CommandFactory.new(bot, routes)
    end

    def resolve(message)
      user = FindUserService.new.find message
      command_factory.create_command(user, message).call
    rescue StandardError => e
      Settings.logger.error e.message
      Settings.logger.error e.backtrace
    end
  end
end
