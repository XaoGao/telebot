# frozen_string_literal: true

class StartCommand < ApplicationCommand
  try :send_hello_prepere_choose_city

  private

  def send_hello_prepere_choose_city
    user.choose_city
    user.save
    cities = keyboard [%w(Москва Санкт-Петербург), %w(Самара)]
    send_message(text: hello_message, reply_markup: cities)
  end

  def hello_message
    message = <<~MESSAGE
Привет, #{user.first_name} 👋
Мы рады, что ваш выбор пал на сеть кофеен Coffee и на бота в частности! Надеюсь, вам тут придется по вкусу!
Прежде чем мы начнем, нам нужно узнать пару вещей о вас. Так как мы представлены в нескольких городах России, и расширяемся по сей дей, сперва выберете город, в котором вы хотите покупать:
    MESSAGE

    message
  end
end
