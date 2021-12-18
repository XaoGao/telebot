# frozen_string_literal: true

require 'logger'

module Telebot
  class Settings
    class << self
      attr_accessor :logger, :telegram_token, :locale_load_path, :locale, :routes

      def configuration
        yield self
      end

      def default_locale_load_paths
        path = if locale_load_path || locale_load_path.empty?
                 'config/locales'
               else
                 locale_load_path
               end

        Dir[File.expand_path(path) + '/*.yml']
      end

      def default_locale
        if locale.nil?
          :ru
        else
          locale
        end
      end

      def telegram_token!
        if telegram_token.nil? || telegram_token.empty?
          raise ArgumentError, 'Set Telebot::Settings.telegram_token!'
        end
      end

      def default_logger
        Logger.new($stdout) if logger.nil?
      end
    end
  end
end
