# frozen_string_literal: true

class RemoveVacationCommand < ApplicationCommand
  try :prepear_to_remove_vacation
  when_error :cancel_action

  private

  def prepear_to_remove_vacation
    user.status_to_remove_exist_vacation
    user.save
    send_message text: I18n.t('command.vacations.remove_vacation.ask_vacation')
  end

  def cancel_action
    send_message text: I18n.t('command.vacations.remove_vacation.cancel_action')
    user.close_command
  end
end
