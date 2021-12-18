# frozen_string_literal: true

require 'logger'
require 'forwardable'
# deprecated
module Telebot
  class Log
    class << self
      extend Forwardable
      def_delegators :logger, :debug, :info, :warn, :error, :fatal

      attr_accessor :logger

      def setup_logger(new_logger = nil)
        @logger = new_logger.nil? ? Logger.new($stdout) : new_logger
      end

      private

      def default_logger
        Logger.new($stdout)
      end
    end
  end
end
