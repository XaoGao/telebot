require 'aasm'
require_relative './concerns/date_formatter'

class User < Sequel::Model(DB)
  include AASM
  extend DateFormatter
  plugin :timestamps, update_on_create: true

  one_to_many :vacations

  date :date_of_birth

  aasm :actions, column: :action do
    state :empty, initial: true
    state :add_date_of_birth
    # state :add_vacation

    event :add_date_of_birth do
      transitions from: :empty, to: :add_date_of_birth
    end

    # event :add_vacation do
    #   transitions from: :empty, to: :add_vacation
    # end

    event :clear do
      transitions to: :empty
    end

    after_all_transitions :log_status
  end

  def self.actions
    aasm(:actions).states.map(&:name).filter { |a| a != default_state }
  end

  def self.default_state
    User.aasm(:actions).initial_state
  end

  def self.get_or_create_from_message(message)
    user = find(chat_id: message.chat.id)
    return user unless user.nil?

    create(
      chat_id: message.chat.id,
      first_name: message.from.first_name,
      last_name: message.from.last_name,
      username: message.from.username
    )
  end

  def full_name
    "#{last_name} #{first_name}"
  end

  # convert action name to class name, example: add_date_of_birth -> AddDateOfBirth
  def camelize_action
    action.split('_').collect(&:capitalize).join
  end

  def log_statusp
    Log.info "#{full_name} chanched status to #{aasm(:actions).current_event}"
  end
end
