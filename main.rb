# frozen_string_literal: true

require 'dotenv/load'
require 'telegram/bot'
require './lib/boot'
module TelegramBot
  Telegram::Bot::Client.run(TOKEN, logger: Log) do |bot|
    router = Router.new(bot, ROUTES)
    bot.logger.info('Bot has been started')

    bot.listen do |message|
      router.resolve(message)
    end
  end
end
