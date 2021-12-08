# frozen_string_literal: true

class ChooseGenderAction < ApplicationCommand
  try :set_gender_prepeare_set_update_date_of_birth

  private

  def set_gender_prepeare_set_update_date_of_birth
    user.status_to_set_date_of_birth
    user.gender = gender_num
    user.save
    send_message(text: I18n.t('command.start.date_of_birth'))
  end

  def gender_num
    message.text == I18n.t('command.start.genders.m') ? 0 : 1
  end
end
