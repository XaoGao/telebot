require 'byebug'

module HelperMethods
  def read_routes
    _routes ||= YAML.load(File.read(File.join(File.dirname(__FILE__), 'test_routes.yml')))
  end

  def create_message(options)
    chat = create_chat(chat_id: options[:chat_id])
    from = create_from(first_name: options[:first_name], last_name: options[:last_name], username: options[:username])

    message = double
    allow(message).to receive(:chat).and_return(chat)
    allow(message).to receive(:from).and_return(from)

    allow(message).to receive(:text).and_return(options[:text])

    message
  end

  def create_chat(options)
    chat = double
    allow(chat).to receive(:id).and_return(options[:chat_id])

    chat
  end

  def create_from(options)
    from = double
    allow(from).to receive(:first_name).and_return(options[:first_name])
    allow(from).to receive(:last_name).and_return(options[:last_name])
    allow(from).to receive(:username).and_return(options[:username])

    from
  end
end
