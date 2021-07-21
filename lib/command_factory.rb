class CommandFactory
  attr_reader :bot, :message, :user

  def initialize(bot, message, user)
    @bot = bot
    @message = message
    @user = user
  end

  def create_command(routes)
    if user_in_action? user
      return action
    end
    if routes.key?(message.text)
      return command(routes)
    end
    # nil object
    Command.new(bot, message, user)
  end

  private

  def command(routes)
    klass = Object.const_get("#{routes[message.text]}Command")
    klass.new(bot, message, user)
  end

  def action
    klass = Object.const_get("#{user.camelize_action}Action")
    klass.new(bot, message, user)
  end

  def user_in_action?(user)
    User.actions.include? user.action.to_sym
  end
end
