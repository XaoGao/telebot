# frozen_string_literal: true

class TestCommand < ApplicationCommand
  try :send_info_message

  private

  def send_info_message
    send_message(text: user.full_info)
  end
end
