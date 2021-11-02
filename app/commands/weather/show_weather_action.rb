class ShowWeatherAction < Command
  attr_reader :wather

  def initialize(bot, message, user)
    super bot, message, user

    @weathe_client = Weather.new
  end

  def call
    response = @weathe_client.by_city message.text
    send_message text: response.info
  rescue StandardError => e
    Log.error e.message
    Log.error e.backtrace
    send_message text: 'Ошибка во время получения погоды'
  ensure
    user.clear
    user.save
  end
end
