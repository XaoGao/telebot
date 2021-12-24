# frozen_string_literal: true

module HelperMethods
  def test_routes
    YAML.safe_load(File.read(File.join(File.dirname(__FILE__), 'test_routes.yml')))
  end

  def create_message(options)
    chat = instance_double(Telegram::Bot::Types::Chat, id: options[:chat_id])
    from = instance_double(Telegram::Bot::Types::User,
                           first_name: options[:first_name],
                           last_name: options[:last_name],
                           username: options[:username])

    instance_double(Telegram::Bot::Types::Message, chat: chat, from: from, text: options[:text])
  end

  def create_callback(options)
    from = instance_double(Telegram::Bot::Types::User,
                           id: options[:id],
                           first_name: options[:first_name],
                           last_name: options[:last_name],
                           username: options[:username])

    instance_double(Telegram::Bot::Types::CallbackQuery, from: from)
  end
end
