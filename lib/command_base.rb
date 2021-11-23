# frozen_string_literal: true

class CommandBase
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
    send_call_back(:before_call)
    begin
      send_call_back(:try)
    rescue StandardError => e
      send_call_back(:when_error)
      Log.error e.message
      Log.error e.backtrace
    ensure
      send_call_back(:finally)
    end
    send_call_back(:after_call)
  end

  def command_done
    user.close_command
    user.save
  end

  def send_call_back(call_back_name)
    step = self.class.send("#{call_back_name}_step")
    send(self.class.send("#{call_back_name}_step")) unless step.nil?
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
