# frozen_string_literal: true

class CreateOrderAction < ApplicationCommand
  try :create_order
  when_error :send_error
  finally :command_done

  private

  def create_order
    item = Item.find(id: message.data)
    user.add_order(item: item)
    user.save
    send_message text: 'Заказ успешно создан!', chat_id: message.message.chat.id
  end

  def send_error
    send_message text: 'Возникла непредвиденная ошибка в ходе выбора', chat_id: message.message.chat.id
  end
end
