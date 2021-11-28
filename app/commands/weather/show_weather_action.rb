# frozen_string_literal: true

class ShowWeatherAction < ApplicationCommand
  def initialize(bot, message, user)
    super bot, message, user

    @weathe_client = WeatherService.new
  end

  try :send_weather
  when_error :send_error
  finally :command_done

  private

  def send_weather
    response = @weathe_client.by_city message.text
    send_message text: response.info
  end

  def send_error
    send_message text: 'Ошибка во время получения погоды'
  end
end
