class WeatherResponse
  attr_reader :temp_c, :wind_mph, :condition

  def initialize(options)
    json = JSON.parse options
    @temp_c = json['current']['temp_c']
    @wind_mph = json['current']['wind_mph']
    @condition = json['current']['condition']['text']
  end

  def info
    "Температура: #{temp_c}, скорость ветра: #{wind_mph}, погода: #{condition}"
  end
end
