# frozen_string_literal: true

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])
# Bundler.require

class Application
  def self.root
    @root ||= File.dirname(File.expand_path('..', __FILE__))
  end

  def self.env
    @env ||= ENV['ENV'] || 'development'
  end

  def self.telegram_token
    @telegram_token ||= ENV['TELEGRAM_BOT_TOKEN']
  end

  def self.logger
    @logger ||= Logger.new($stdout)
  end
end
