# frozen_string_literal: true

require_relative '../application'

Telebot::Settings.configuration do |config|
  config.telegram_token = ENV['TELEGRAM_BOT_TOKEN']
  # config.logger = Application.logger
  config.locale_load_path = 'config/locales'
  config.locale = :ru
  config.routes = Application.routes
end
