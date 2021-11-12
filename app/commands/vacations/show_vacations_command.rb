class ShowVacationsCommand < Command
  def call
    if user.vacations?
      user.vacations.each_with_index do |vacation, index|
        send_message text: "#{index + 1}) #{vacation.interval}; id = #{vacation.id}"
      end
    else
      send_message text: 'Отпусков нет'
    end
  end
end
