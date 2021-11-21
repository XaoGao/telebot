# frozen_string_literal: true

class RemoveVacationCommand < Command
  try :prepear_to_remove_vacation
  when_error :cancel_action

  private

  def prepear_to_remove_vacation
    user.remove_exist_vacation
    user.save
    send_message text: 'Укажите идентификатор отпуска, который будет удален'
  end

  def cancel_action
    send_message text: 'Во время выполнения команды возникла ошибка, попробуйте позже'
    user.close_command
  end
end
