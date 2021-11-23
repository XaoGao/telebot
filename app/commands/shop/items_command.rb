# frozen_string_literal: true

class ItemsCommand < CommandBase
  try :prepear_to_choose_item

  private

  def prepear_to_choose_item
    user.choose_item
    user.save

    Item.all.each do |item|
      kb = [Telegram::Bot::Types::InlineKeyboardButton.new(text: item.price, callback_data: item.id)]
      markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
      send_message(text: item.name, reply_markup: markup)
    end
  end
end
