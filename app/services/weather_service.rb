# frozen_string_literal: true

require 'faraday'

class WeatherService
  def initialize(client = nil)
    @client = client || default_client
    @api_key = ENV['API_KEY_WEATHER']
    @base_url = 'http://api.weatherapi.com/v1/current.json'
  end

  def by_city(city_name)
    response = @client.get("#{@base_url}?key=#{@api_key}&q=#{city_name}")

    raise if response.status != 200

    WeatherResponse.new(response.body)
  end

  private

  def default_client
    Faraday
  end
end
