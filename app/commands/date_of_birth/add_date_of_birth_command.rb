class AddDateOfBirthCommand < Command
  def call
    user.add_date_of_birth
    user.save
    send_message text: text
  end

  private

  def text
    'Укажите дату в формате dd.MM.yyyy'
  end
end
