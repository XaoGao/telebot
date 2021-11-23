# frozen_string_literal: true

module HelperMethods
  def read_routes
    _routes ||= YAML.safe_load(File.read(File.join(File.dirname(__FILE__), 'test_routes.yml')))
  end

  def create_message(options)
    chat = create_chat(chat_id: options[:chat_id])
    from = create_from(first_name: options[:first_name], last_name: options[:last_name], username: options[:username])

    instance_double(Telegram::Bot::Types::Message, chat: chat, from: from, text: options[:text])
  end

  def create_chat(options)
    double(id: options[:chat_id])
  end

  def create_from(options)
    double(first_name: options[:first_name], last_name: options[:last_name], username: options[:username])
  end
end
