# frozen_string_literal: true

class UpdateDateOfBirthCommand < ApplicationCommand
  try :prepear_to_update_date_of_birth

  private

  def prepear_to_update_date_of_birth
    user.update_date_of_birth
    if user.valid?
      user.save
      send_message text: I18n.t('command.start.date_of_birth')
    else
      user.erros.each do |_key, value|
        send_message text: value
      end
    end
  end
end
