# frozen_string_literal: true

module Telebot
  class Router
    attr_reader :command_factory, :find_user_service

    def initialize(bot, routes)
      raise ArgumentError, 'Set Telebot::Settings.routes!' if routes.nil?

      @command_factory = CommandFactory.new(bot, routes)
      @find_user_service = FindUserService.new
    end

    def resolve(message)
      user = find_user_service.find message
      command = command_factory.create_command(user, message)
      command.call
    rescue StandardError => e
      Telebot::Settings.safe_logger.error e.message
      Telebot::Settings.safe_logger.error e.backtrace
      nil
    end
  end
end
