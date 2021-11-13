require 'date'

class AddNewVacationAction < Command
  def call
    add_new_vacation
  rescue StandardError => e
    Log.error e.message
    Log.error e.backtrace
    send_message text: error
  ensure
    user.clear
    user.save
  end

  private

  def add_new_vacation
    from_str, by_str = message.text.split('-')
    range = VacationRange.new(from_str, by_str)

    user.add_vacation(from: range.from, by: range.by)
    user.save
    send_message text: text(message)
  end

  def text(message)
    "Отпуск #{message.text} успешно сохранен"
  end

  def error
    'Некорректный форматы даты!'
  end
end
