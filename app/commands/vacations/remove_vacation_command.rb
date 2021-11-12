class RemoveVacationCommand < Command
  def call
    user.remove_exist_vacation
    user.save
    send_message text: text
  rescue StandardError => e
    Log.error e.message
    Log.error e.backtrace
    send_message text: 'Во время выполнения команды возникла ошибка, попробуйте позже'
    user.clear
    user.save
  end

  private

  def text
    'Укажите идентификатор отпуска, который будет удален'
  end
end
