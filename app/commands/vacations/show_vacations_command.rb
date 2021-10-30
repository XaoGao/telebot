class ShowVacationsCommand < Command
  def call
    if user.vacations?
      user.vacations.each do |vacation|
        send_message text: vacation.interval
      end
    else
      send_message text: 'Отпусков нет'
    end
  end
end
