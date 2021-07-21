require 'dotenv/load'
require 'telegram/bot'
require './lib/boot'

module TelegramBot
  Telegram::Bot::Client.run(TOKEN) do |bot|
    router = Router.new(bot, ROUTES)
    Log.info 'Start listen'
    bot.listen do |message|
      router.resolve(message)
    end
  end
end
