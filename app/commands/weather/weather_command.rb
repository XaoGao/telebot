class WeatherCommand < Command
  def call
    user.show_weather
    user.save
    send_message text: text
  end

  private

  def text
    'Укажите город'
  end
end
