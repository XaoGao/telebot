# frozen_string_literal: true

require 'dotenv/load'
require 'telegram/bot'
require_relative './boot'

module Telebot
  def self.start
    Telegram::Bot::Client.run(TOKEN, logger: Telebot::Log) do |bot|
      router = Telebot::Router.new(bot, ROUTES)
      bot.logger.info('Bot has been started')

      bot.listen do |message|
        router.resolve(message)
      end
    end
  end
end
