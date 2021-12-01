# frozen_string_literal: true

class StartCommand < ApplicationCommand
  try :send_hello_prepere_choose_city

  private

  def send_hello_prepere_choose_city
    user.choose_city
    user.save
    send_message(text: I18n.t('command.start.hello', name: user.first_name), reply_markup: cities)
  end

  def cities
    keyboard [[I18n.t('command.start.cities.moscow'), I18n.t('command.start.cities.saint-petersburg')], [I18n.t('command.start.cities.samara')]]
  end
end
