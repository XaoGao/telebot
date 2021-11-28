# frozen_string_literal: true

class WeatherCommand < ApplicationCommand
  try :prepear_to_get_city_name

  private

  def prepear_to_get_city_name
    user.show_weather
    user.save
    send_message text: 'Укажите город'
  end
end
