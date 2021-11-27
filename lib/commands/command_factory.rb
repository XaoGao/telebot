# frozen_string_literal: true

require_relative '../helpers/utils'
module Telebot
  class CommandFactory
    using Helpers::Utils
    attr_reader :bot, :message, :user

    def initialize(bot, message, user)
      @bot = bot
      @message = message
      @user = user
    end

    def create_command(routes)
      return action if user&.in_action?
      return command(routes) if routes.key?(message.text)

      NilCommand.new(bot, message, user)
    end

    private

    def command(routes)
      klass = Object.const_get("#{routes[message.text]}Command")
      klass.new(bot, message, user)
    end

    def action
      klass = Object.const_get("#{user.action.to_camel_case}Action")
      klass.new(bot, message, user)
    end
  end
end