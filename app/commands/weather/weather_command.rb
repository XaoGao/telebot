# frozen_string_literal: true

class WeatherCommand < ApplicationCommand
  try :prepear_to_get_city_name

  private

  def prepear_to_get_city_name
    user.status_to_show_weather
    user.save
    send_message text: I18n.t('command.weather.choose_city')
  end
end
