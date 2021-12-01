# frozen_string_literal: true

class SetDateOfBirthAction < ApplicationCommand
  try        :try_set_date_of_birth
  when_error :send_error_message

  private

  def try_set_date_of_birth
    if message.text == 'Пропустить'
      close_command_with_message 'Вы можете указать дату рождения позже'
    else
      user.date_of_birth = parse_date_of_birth message
      check_user_and_notificate user
    end
  end

  def send_error_message
    skip = keyboard [%w(Пропустить)]
    send_message(text: 'Некорректный формат даты! Повторите ввод даты или пропустите', reply_markup: skip)
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
      close_command_with_message "#{user.date_of_birth_format} успешно сохранена"
    else
      send_error_message
    end
  end
end
