# frozen_string_literal: true

require_relative '../application'

Telebot::Settings.configuration do |config|
  config.telegram_token = ENV['TELEGRAM_BOT_TOKEN']
  config.logger = Application.logger
end
