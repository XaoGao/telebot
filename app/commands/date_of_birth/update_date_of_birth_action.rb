require 'date'

class UpdateDateOfBirthAction < Command
  try :add_date_of_birth
  when_error :catch_error
  finally :clear_user

  private

  def add_date_of_birth
    old_date = user.date_of_birth
    new_date = parse_date_of_birth message

    user.date_of_birth = new_date
    if user.valid?
      send_message text: success_message(user.date_of_birth_format)
    else
      send_message_date_is_invalid
    end
  end

  def catch_error
    send_message text: 'Некорректный формат даты!'
  end

  def clear_user
    user.clear
    user.save
  end

  def success_message(date)
    "#{date} успешно сохранена"
  end

  def parse_date_of_birth(message)
    DateTime.parse message.text
  end

  def send_message_date_is_invalid
    user.date_of_birth = old_date
    user.errors.each do |key, value|
      send_message text: value
    end
  end
end
