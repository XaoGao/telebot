class CommandFactory
  attr_reader :bot, :message, :user

  def initialize(bot, message, user)
    @bot = bot
    @message = message
    @user = user
  end

  def create_command(routes)
    if user.in_action?
      return action
    end
    if routes.key?(message.text)
      return command(routes)
    end
    NilCommand.new(bot, message, user)
  end

  private

  def command(routes)
    klass = Object.const_get("#{routes[message.text]}Command")
    klass.new(bot, message, user)
  end

  def action
    klass = Object.const_get("#{user.action.to_camel_case}Action")
    klass.new(bot, message, user)
  end
end
