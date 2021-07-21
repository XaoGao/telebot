require 'date'

class AddDateOfBirthAction < Command
  def call
    date = DateTime.parse message.text
    user.update(date_of_birth: date)
    send_message text: text(user.date_of_birth_format)
  rescue StandardError => e
    send_message text: error
  ensure
    user.clear
    user.save
  end

  private

  def text(date)
    "#{date} успешно сохранена"
  end

  def error
    'Некорректный форматы даты!'
  end
end
