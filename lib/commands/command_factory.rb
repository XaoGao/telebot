# frozen_string_literal: true

require_relative '../helpers/utils'
module Telebot
  class CommandFactory
    using Helpers::Utils
    attr_reader :bot, :routes

    def initialize(bot, routes)
      @bot = bot
      @routes = routes
    end

    def create_command(user, message)
      return action(user, message) if user&.in_action?
      return command(user, message, routes) if routes.key?(message.text)

      NilCommand.new(bot, message, user)
    end

    private

    def command(user, message, routes)
      klass = Object.const_get("#{routes[message.text]}Command")
      klass.new(bot, message, user)
    end

    def action(user, message)
      klass = Object.const_get("#{user.action.to_camel_case}Action")
      klass.new(bot, message, user)
    end
  end
end
