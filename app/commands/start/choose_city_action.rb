# frozen_string_literal: true

class ChooseCityAction < ApplicationCommand
  try :set_city_prepeare_choose_gender

  private

  def set_city_prepeare_choose_gender
    user.status_to_choose_gender
    user.address = message.text
    user.save
    genders = keyboard [[I18n.t('command.start.genders.m'), I18n.t('command.start.genders.w')]]
    send_message(text: I18n.t('command.start.gender'), reply_markup: genders)
  end
end
