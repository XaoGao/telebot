class RemoveExistVacationAction < Command
  def call
    remove_vacation
  rescue StandardError => e
    Log.error e.message
    Log.error e.backtrace
    send_message text: error
  ensure
    user.clear
    user.save
  end

  private

  def remove_vacation
    vacation = Vacation.find(id: message.text)
    if vacation.nil?
      send_message text: 'Отпуска с указаным идентификатором нет'
      return
    end
    user.remove_vacation(vacation)
    user.save
    send_message text: text
  end

  def text
    'Отпуск успешно удален'
  end

  def error
    'Ошибка при удалении отпуска'
  end
end
