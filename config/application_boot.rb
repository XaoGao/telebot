# frozen_string_literal: true

require 'i18n'

module TelegramBot
  module ApplicationBoot
    Application.logger.info 'Loading locales'

    I18n.load_path << Dir[File.expand_path('config/locales') + '/*.yml']
    I18n.default_locale = :ru

    Application.logger.info 'Locales loaded'
  end
end
