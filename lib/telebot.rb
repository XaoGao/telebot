# frozen_string_literal: true

require 'telegram/bot'
require_relative './settings'
require_relative './router'
require_relative './commands/command_base'
require_relative './commands/nil_command'
require_relative './commands/command_factory'
require_relative './generators/cli'
require_relative './scheduler_config'
require_relative './services/find_user_service'
require_relative './boot'

module Telebot
  # infinity loop
  def self.start
    Telegram::Bot::Client.run(Settings.telegram_token!, logger: Settings.safe_logger) do |bot|
      router = Router.new(bot, Settings.routes)
      bot.logger.info('Bot has been started')

      bot.listen do |message|
        router.resolve(message)
      end
    end
  end
end
