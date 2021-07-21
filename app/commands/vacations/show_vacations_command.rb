class ShowVacationsCommand < Command
  def call
    vacations = user.vacations
    if vacations.count.zero?
      send_message text: 'Отпусков нет'
    else
      vacations.each do |vacation|
        send_message text: vacation.interval
      end
    end
  end
end
