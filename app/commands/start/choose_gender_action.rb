# frozen_string_literal: true

class ChooseGenderAction < Telebot::CommandBase
  try :set_gender_prepeare_set_update_date_of_birth

  private

  def set_gender_prepeare_set_update_date_of_birth
    user.set_date_of_birth
    user.gender = gender_num
    user.save
    send_message(text: set_update_date_of_birth_message)
  end

  def set_update_date_of_birth_message
    message = <<~MESSAGE
🎂 Введи дату своего рождения в формате дд.мм.гггг, и получи в день своего праздника напиток за один рубль!
    MESSAGE

    message
  end

  def gender_num
    message.text == 'M' ? 0 : 1
  end
end
