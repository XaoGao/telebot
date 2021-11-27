# frozen_string_literal: true

require 'faraday'

class ItemsCommand < Telebot::CommandBase
  try :prepear_to_choose_item

  private

  def prepear_to_choose_item
    user.choose_item
    user.save

    Item.all.each do |item|
      kb = [Telegram::Bot::Types::InlineKeyboardButton.new(text: item.price_info, callback_data: item.id)]
      markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
      send_photo(photo: Faraday::UploadIO.new(item.path_to_image, 'image/jpeg'))
      send_message(text: item.info, reply_markup: markup)
    end
  end
end
