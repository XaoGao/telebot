# frozen_string_literal: true

module BotAction
  def send_message(text:, chat_id: message.chat.id, reply_markup: nil)
    bot.api.send_message(chat_id: chat_id, text: text, reply_markup: reply_markup)
  end

  def send_photo(photo:, chat_id: message.chat.id)
    bot.api.send_photo(chat_id: chat_id, photo: photo)
  end
end
