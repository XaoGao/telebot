class StartCommand < Command
  def call
    send_message(text: text)
  end

  private

  def text
    "Hello #{user.full_info}!"
  end
end
