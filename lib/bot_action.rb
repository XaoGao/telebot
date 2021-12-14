# frozen_string_literal: true

module Telebot
  module BotAction
    def send_message(text:, chat_id: message.chat.id, reply_markup: nil)
      bot.api.send_message(chat_id: chat_id, text: text, reply_markup: reply_markup)
    end

    def send_photo(photo:, chat_id: message.chat.id)
      bot.api.send_photo(chat_id: chat_id, photo: photo)
    end

    def keyboard(buttons, one_time_keyboard: true)
      Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: buttons, one_time_keyboard: one_time_keyboard)
    end

    def inline_keyboard(buttons)
      kb = buttons.map do |button|
        Telegram::Bot::Types::InlineKeyboardButton.new(text: button[:text], callback_data: button[:value])
      end
      Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
    end
  end
end
