# frozen_string_literal: true

class ChooseCityAction < ApplicationCommand
  try :set_city_prepeare_choose_gender

  private

  def set_city_prepeare_choose_gender
    user.choose_gender
    user.address = message.text
    user.save
    genders = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: [%w(М Ж)], one_time_keyboard: true)
    send_message(text: choose_gender_message, reply_markup: genders)
  end

  def choose_gender_message
    message = <<~MESSAGE
👫 Леди или джентльмен?

Выбери одно из двух, что бы получить 50%-ую скидку на заказ 23 февраля или 8 марта!
    MESSAGE

    message
  end
end
