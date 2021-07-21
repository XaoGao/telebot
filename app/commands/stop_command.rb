class StopCommand < Command
  def call
    send_message(text: 'stop')
  end
end
