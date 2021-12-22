# frozen_string_literal: true

require 'dotenv/load'
require_relative './config/application'
require_relative './config/application_boot'
require_relative './lib/telebot'

module TelegramBot
  def self.start
    Telebot.start
  end
end

TelegramBot.start
