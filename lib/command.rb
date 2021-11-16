require 'byebug'
class Command
  include BotAction
  attr_reader :bot, :message, :user

  def initialize(bot, message, user)
    @bot = bot
    @message = message
    @user = user
  end

  def call
    if !self.class.before_call_step.nil?
      send(self.class.before_call_step)
    end

    begin
      if !self.class.try_step.nil?
        send(self.class.try_step)
      end
    rescue StandardError => e
      if !self.class.when_error_step.nil?
        send(self.class.when_error_step)
      end
      Log.error e.message
      Log.error e.backtrace
    ensure
      if !self.class.finally_step.nil?
        send(self.class.finally_step)
      end
    end
    if !self.class.after_call_step.nil?
      send(self.class.after_call_step)
    end
  end

  class << self
    attr_reader :before_call_step, :after_call_step, :try_step, :when_error_step, :finally_step

    def before_call(method_name)
      @before_call_step = method_name.to_sym
    end

    def after_call(method_name)
      @after_call_step = method_name.to_sym
    end

    def try(method_name)
      @try_step = method_name.to_sym
    end

    def when_error(method_name)
      @when_error_step = method_name.to_sym
    end

    def finally(method_name)
      @finally_step = method_name.to_sym
    end
  end
end
