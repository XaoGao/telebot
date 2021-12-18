# frozen_string_literal: true

require 'telegram/bot'
require_relative './boot'

module Telebot
  # infinity loop
  def self.start
    Telegram::Bot::Client.run(Settings.telegram_token!, logger: Settings.logger) do |bot|
      router = Router.new(bot, Settings.routes)
      bot.logger.info('Bot has been started')

      bot.listen do |message|
        router.resolve(message)
      end
    end
  end
end
