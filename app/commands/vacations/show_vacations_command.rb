class ShowVacationsCommand < Command
  def call
    if user.vacations?
      send_message text: 'Отпусков нет'
    else
      user.vacations.each do |vacation|
        send_message text: vacation.interval
      end
    end
  end
end
