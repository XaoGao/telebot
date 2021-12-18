# frozen_string_literal: true

require 'dotenv/load'
require_relative './config/application'
require_relative './lib/telebot'

Telebot.start
