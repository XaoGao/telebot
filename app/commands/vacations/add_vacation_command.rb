class AddVacationCommand < Command
  def call
    user.add_new_vacation
    user.save
    send_message text: text
  end

  private

  def text
    'Укажите дату в формате dd.MM.yyyy - dd.MM.yyyy'
  end
end
