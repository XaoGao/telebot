# frozen_string_literal: true

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])
# Bundler.require
require 'yaml'
require 'logger'
require 'dotenv/load'

module TelegramBot
  class Application
    class << self
      def root
        @root ||= File.dirname(File.expand_path('..', __FILE__))
      end

      def env
        @env ||= ENV['ENV'] || 'development'
      end

      def logger
        @logger ||= Logger.new($stdout)
      end

      def routes
        @routes ||= YAML.safe_load(File.read(File.join(File.dirname(__FILE__), '..', 'app', 'routes.yml')))
      end
    end
  end
end
