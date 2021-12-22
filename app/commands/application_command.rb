# frozen_string_literal: true

class ApplicationCommand < Telebot::CommandBase
  def command_done
    user.close_command
    user.save
  end
end
