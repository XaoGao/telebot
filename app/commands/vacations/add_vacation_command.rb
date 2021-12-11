# frozen_string_literal: true

class AddVacationCommand < ApplicationCommand
  try :prepear_to_add_vacation

  private

  def prepear_to_add_vacation
    user.status_to_add_new_vacation
    user.save
    send_message text: I18n.t('command.vacations.add_new_vacation.ask_range')
  end
end
