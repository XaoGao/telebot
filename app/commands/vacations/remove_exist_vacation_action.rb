# frozen_string_literal: true

class RemoveExistVacationAction < ApplicationCommand
  try :remove_vacation
  when_error :send_error
  finally :command_done

  private

  def remove_vacation
    vacation = Vacation.find(id: message.text)
    if vacation.nil?
      send_message text: I18n.t('command.vacations.remove_vacation.not_found')
      return
    end
    user.remove_vacation(vacation)
    user.save
    send_message text: I18n.t('command.vacations.remove_vacation.success')
  end

  def send_error
    send_message text: I18n.t('command.vacations.remove_vacation.error')
  end
end
