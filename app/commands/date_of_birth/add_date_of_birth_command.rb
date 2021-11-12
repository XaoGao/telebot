class AddDateOfBirthCommand < Command
  def call
    user.add_date_of_birth
    if user.valid?
      user.save
      send_message text: text
    else
      user.erros.each do |key, value|
        send_message text: value
      end
    end
  end

  private

  def text
    'Укажите дату в формате dd.MM.yyyy'
  end
end
