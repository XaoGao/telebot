require 'date'
class AddDateOfBirthAction < Command
  def call
    add_date_of_birth
  rescue StandardError => e
    Log.error e.message
    Log.error e.backtrace
  ensure
    user.clear
    user.save
  end

  private

  def add_date_of_birth
    old_date = user.date_of_birth
    new_date = parse_date_of_birth message

    user.date_of_birth = new_date
    if user.valid?
      send_message text: text(user.date_of_birth_format)
    else
      user.date_of_birth = old_date
      user.errors.each do |key, value|
        send_message text: value
      end
    end
  end

  def text(date)
    "#{date} успешно сохранена"
  end

  def error
    'Некорректный формат даты!'
  end

  def parse_date_of_birth(message)
    DateTime.parse message.text
  end
end
