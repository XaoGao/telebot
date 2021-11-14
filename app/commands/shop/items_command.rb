class ItemsCommand < Command
  def call
    user.choose_item
    user.save

    Item.all.each do |item|
      kb = [Telegram::Bot::Types::InlineKeyboardButton.new(text: item.price, callback_data: item.id)]
      markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
      send_message(text: item.name, reply_markup: markup)
    end
  end
end
