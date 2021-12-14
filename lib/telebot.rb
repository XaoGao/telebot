# frozen_string_literal: true

require 'dotenv/load'
require 'telegram/bot'
require_relative './boot'

module Telebot
  # infinity loop
  def self.start
    Telegram::Bot::Client.run(Application.telegram_token, logger: Telebot::Log) do |bot|
      router = Telebot::Router.new(bot, Application.routes)
      bot.logger.info('Bot has been started')

      bot.listen do |message|
        router.resolve(message)
      end
    end
  end
end
