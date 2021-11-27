# frozen_string_literal: true

require 'logger'
require 'forwardable'

module Telebot
  class Log
    class << self
      extend Forwardable
      def_delegators :logger, :debug, :info, :warn, :error, :fatal

      private

      def logger
        @logger ||= Logger.new($stdout)
      end
    end
  end
end
