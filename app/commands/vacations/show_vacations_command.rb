# frozen_string_literal: true

class ShowVacationsCommand < ApplicationCommand
  try :show_vacations
  when_error :send_error

  private

  def show_vacations
    if user.vacations?
      user.vacations.each_with_index do |vacation, index|
        send_message text: "#{index + 1}) #{vacation.interval}; id = #{vacation.id}"
      end
    else
      send_message text: I18n.t('command.vacations.show.have_not')
    end
  end

  def send_error
    send_message text: I18n.t('command.vacations.show.error')
  end
end
