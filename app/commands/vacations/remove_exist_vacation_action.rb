# frozen_string_literal: true

class RemoveExistVacationAction < Command
  try :remove_vacation
  when_error :send_error
  finally :command_done

  private

  def remove_vacation
    vacation = Vacation.find(id: message.text)
    if vacation.nil?
      send_message text: 'Отпуска с указаным идентификатором нет'
      return
    end
    user.remove_vacation(vacation)
    user.save
    send_message text: 'Отпуск успешно удален'
  end

  def send_error
    send_message text: 'Ошибка при удалении отпуска'
  end
end
