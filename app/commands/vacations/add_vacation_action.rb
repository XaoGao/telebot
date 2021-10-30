require 'date'
require 'byebug'

class AddVacationAction < Command
  def call
    from_str, by_str = message.text.split('-')
    range = VacationRange.new(from_str, by_str)

    user.vacations.create(from: range.from, by: range.by)
    send_message text: text(message)
  rescue StandardError => e
    Log.error e.message
    Log.error e.backtrace
    send_message text: error
  ensure
    user.clear
    user.save
  end

  private

  def text(message)
    "Отпуск #{message.text} успешно сохранена"
  end

  def error
    'Некорректный форматы даты!'
  end
end
