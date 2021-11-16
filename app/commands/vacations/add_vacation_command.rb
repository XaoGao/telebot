class AddVacationCommand < Command
  try :prepear_to_add_vacation

  private

  def prepear_to_add_vacation
    user.add_new_vacation
    user.save
    send_message text: text
  end

  def text
    'Укажите дату в формате dd.MM.yyyy - dd.MM.yyyy'
  end
end
