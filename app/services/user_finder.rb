class UserFinder
  def find(bot_message)
    case bot_message
    when Telegram::Bot::Types::CallbackQuery
      User.find(chat_id: bot_message.from.id)
    when Telegram::Bot::Types::Message
      User.get_or_create_from_message bot_message
    else
      nil
    end
  end
end
