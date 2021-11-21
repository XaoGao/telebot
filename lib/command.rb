# frozen_string_literal: true

class Command
  include BotAction
  attr_reader :bot, :message, :user

  CALL_BACKS = %i[before_call after_call try when_error finally].freeze
  private_constant :CALL_BACKS

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
    CALL_BACKS.each do |callback_name|
      attr_reader "#{callback_name}_step".to_sym
    end
  end

  CALL_BACKS.each do |callback_name|
    define_singleton_method(callback_name.to_sym) do |value|
      instance_variable_set("@#{callback_name}_step", value.to_sym)
    end
  end
end
