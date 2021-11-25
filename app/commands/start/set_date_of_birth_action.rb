# frozen_string_literal: true

class SetDateOfBirthAction < CommandBase
  try :set_update_date_of_birth
  when_error :send_error
  finally :command_done

  private

  def set_update_date_of_birth
    new_date = parse_date_of_birth message

    user.date_of_birth = new_date
    if user.valid?
      send_message text: success_message(user.date_of_birth_format)
    else
      send_message_date_is_invalid
    end
  end

  def send_error
    send_message text: 'Некорректный формат даты!'
  end

  def success_message(date)
    "#{date} успешно сохранена"
  end

  def parse_date_of_birth(message)
    DateTime.parse message.text
  end
end
