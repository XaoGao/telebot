# frozen_string_literal: true

class StopCommand < Telebot::CommandBase
  try :send_bye

  private

  def send_bye
    send_message(text: text)
  end

  def text
    "Bye, #{user.full_name}!"
  end
end
