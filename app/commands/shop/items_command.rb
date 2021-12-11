# frozen_string_literal: true

class ItemsCommand < ApplicationCommand
  try :prepear_to_choose_item
  when_error :command_done

  private

  def prepear_to_choose_item
    Item.all.each do |item|
      markup = inline_keyboard([{ text: item.price_info, value: item.id }])
      send_photo(photo: item.upload_attachment)
      send_message(text: item.info, reply_markup: markup)
    end
    user.status_to_choose_item
    user.save
  end
end
