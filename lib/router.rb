class Router
  attr_reader :bot, :routes

  def initialize(bot, routes)
    @bot = bot
    @routes = routes
  end

  def resolve(message)
    case message
    when Telegram::Bot::Types::CallbackQuery
      user = User.find(chat_id: message.from.id)
    when Telegram::Bot::Types::Message
      user = User.get_or_create_from_message message
    end
  CommandFactory.new(bot, message, user).create_command(routes).call
  rescue StandardError => e
    Log.error e.message
    Log.error e.backtrace
  end
end
