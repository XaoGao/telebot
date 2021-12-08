# frozen_string_literal: true

class AddVacationCommand < ApplicationCommand
  try :prepear_to_add_vacation

  private

  def prepear_to_add_vacation
    user.status_to_add_new_vacation
    user.save
    send_message text: text
  end

  def text
    'Укажите дату в формате dd.MM.yyyy - dd.MM.yyyy'
  end
end
