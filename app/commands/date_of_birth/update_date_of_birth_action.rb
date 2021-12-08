# frozen_string_literal: true

class UpdateDateOfBirthAction < ApplicationCommand
  try :add_date_of_birth
  when_error :send_error
  finally :command_done

  private

  def add_date_of_birth
    new_date = parse_date_of_birth message

    user.date_of_birth = new_date
    if user.valid?
      send_message text: success_message(user.date_of_birth_format)
    else
      send_message_date_is_invalid
    end
  end

  def send_error
    send_message text: I18n.t('command.start.error_set_date_of_birth')
  end

  def success_message(date)
    I18n.t('command.start.success_set_date_of_birth', date_of_birth: date)
  end

  def parse_date_of_birth(message)
    DateTime.parse message.text
  end

  def send_message_date_is_invalid
    user.errors.each do |_key, value|
      send_message text: value
    end
  end
end
