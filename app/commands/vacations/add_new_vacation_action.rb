require 'date'

class AddNewVacationAction < Command
  try :add_vacation
  when_error :send_error_message
  finally :clear_user

  private

  def add_vacation
    from_str, by_str = message.text.split('-')
    range = VacationRange.new(from_str, by_str)

    user.add_vacation(from: range.from, by: range.by)
    user.save
    send_message text: success_message(message)
  end

  def send_error_message
    send_message text: 'Некорректный форматы даты!'
  end

  def clear_user
    user.clear
    user.save
  end

  def success_message(message)
    "Отпуск #{message.text} успешно сохранен"
  end
end
