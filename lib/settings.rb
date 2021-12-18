# frozen_string_literal: true

module Telebot
  class Settings
    class << self
      attr_accessor :logger, :telegram_token

      def configuration
        yield self
      end
    end
  end
end
