class RemoveExistVacationAction < Command
  def call
    vacation = Vacation.find(id: message.text)
    user.remove_vacation(vacation)
    user.save
    send_message text: text
  rescue StandardError => e
    Log.error e.message
    Log.error e.backtrace
    send_message text: error
  ensure
    user.clear
    user.save
  end

  private

  def text
    'Отпуск успешно удален'
  end

  def error
    'Ошибка при удалении отпуска'
  end
end
