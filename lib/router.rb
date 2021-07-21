class Router
  attr_reader :bot, :routes

  def initialize(bot, routes)
    @bot = bot
    @routes = routes
  end

  def resolve(message)
    user = User.get_or_create_from_message message
    CommandFactory.new(bot, message, user).create_command(routes).call
  rescue StandardError => e
    Log.error e.message
    Log.error e.backtrace
  end
end
