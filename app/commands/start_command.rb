class StartCommand < Command
  def call
    send_message(text: text)
  end

  private

  def text
    "#{user.full_name} #{user.username} #{user.date_of_birth}"
  end
end
