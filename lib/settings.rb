# frozen_string_literal: true

require_relative './nil_logger'

module Telebot
  class Settings
    class << self
      attr_accessor :logger, :telegram_token, :routes

      def configuration
        yield self
      end

      def telegram_token!
        if telegram_token.nil? || telegram_token.empty?
          raise ArgumentError, 'Set Telebot::Settings.telegram_token!'
        end

        telegram_token
      end

      def safe_logger
        if logger.nil?
          NilLogger.new
        else
          logger
        end
      end
    end
  end
end
