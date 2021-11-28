# frozen_string_literal: true

class AddNewVacationAction < ApplicationCommand
  try :add_vacation
  when_error :send_error
  finally :command_done

  private

  def add_vacation
    from_str, by_str = message.text.split('-')
    range = VacationRange.new(from_str, by_str)

    user.add_vacation(from: range.from, by: range.by)
    user.save
    send_message text: success_message(message)
  end

  def send_error
    send_message text: 'Некорректный форматы даты!'
  end

  def success_message(message)
    "Отпуск #{message.text} успешно сохранен"
  end
end
