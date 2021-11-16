class UpdateDateOfBirthCommand < Command
  try :prepear_to_update_date_of_birth

  private

  def prepear_to_update_date_of_birth
    user.update_date_of_birth
    if user.valid?
      user.save
      send_message text: text
    else
      user.erros.each do |key, value|
        send_message text: value
      end
    end
  end

  def text
    'Укажите дату в формате dd.MM.yyyy'
  end
end