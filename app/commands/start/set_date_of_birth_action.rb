# frozen_string_literal: true

class SetDateOfBirthAction < ApplicationCommand
  try        :try_set_date_of_birth
  when_error :send_error_message

  private

  def try_set_date_of_birth
    if message.text == I18n.t('command.start.skip')
      close_command_with_message I18n.t('command.start.skip_set_date_of_birth')
    else
      user.date_of_birth = parse_date_of_birth message
      check_user_and_notificate user
    end
  end

  def send_error_message
    skip = keyboard [I18n.t('command.start.skip')]
    send_message(text: I18n.t('command.start.error_set_date_of_birth'), reply_markup: skip)
  end

  def parse_date_of_birth(message)
    DateTime.parse message.text
  end

  def close_command_with_message(message)
    send_message text: message
    user.close_command
    user.save
  end

  def check_user_and_notificate(user)
    if user.valid?
      close_command_with_message I18n.t('command.start.success_set_date_of_birth',
                                        date_of_birth: user.date_of_birth_format)
    else
      send_error_message
    end
  end
end
