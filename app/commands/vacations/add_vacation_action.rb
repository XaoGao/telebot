require 'date'
require 'byebug'

class AddVacationAction < Command
  def call
    from_str, by_str = message.text.split('-').strip
    byebug
    if from.nil? || by.nil?
      raise
    end
    byebug
    from = DateTime.parse from_str
    by = DateTime.parse by_str

    user.vacations.create(from: from, by: by)
    send_message text: text(message)
  rescue StandardError => e
    send_message text: error
  ensure
    user.clear
    user.save
  end

  private

  def text(message)
    "Отпуск #{message.text} успешно сохранена"
  end

  def error
    'Некорректный форматы даты!'
  end
end