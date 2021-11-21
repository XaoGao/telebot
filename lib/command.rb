# frozen_string_literal: true

class Command
  include BotAction
  attr_reader :bot, :message, :user

  def initialize(bot, message, user)
    @bot = bot
    @message = message
    @user = user
  end

  def call
    send(self.class.before_call_step) unless self.class.before_call_step.nil?
    begin
      send(self.class.try_step) unless self.class.try_step.nil?
    rescue StandardError => e
      send(self.class.when_error_step) unless self.class.when_error_step.nil?
      Log.error e.message
      Log.error e.backtrace
    ensure
      send(self.class.finally_step) unless self.class.finally_step.nil?
    end
    send(self.class.after_call_step) unless self.class.after_call_step.nil?
  end

  def command_done
    user.close_command
    user.save
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
