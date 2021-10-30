require 'date'

class AddDateOfBirthAction < Command
  def call
    date = DateTime.parse message.text
    user.update(date_of_birth: date)
    send_message text: text(user.date_of_birth_format)
  rescue StandardError => e
    Log.error e.message
    Log.error e.backtrace
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
