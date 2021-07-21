class Command
  include BotAction
  attr_reader :bot, :message, :user

  def initialize(bot, message, user)
    @bot = bot
    @message = message
    @user = user
  end

  def call
    # raise NotImplementedError, 'Implement this method in a child class'
  end
end
