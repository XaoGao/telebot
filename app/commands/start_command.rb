class StartCommand < Command
  try :send_hello

  private

  def send_hello
    send_message(text: text)
  end

  def text
    "Hello #{user.full_info}!"
  end
end
