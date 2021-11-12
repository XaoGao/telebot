require 'aasm'
require_relative './concerns/date_formatter'
require 'byebug'

class User < Sequel::Model(DB)
  include AASM
  extend DateFormatter
  plugin :timestamps, update_on_create: true
  plugin :validation_helpers

  one_to_many :vacations

  date :date_of_birth

  aasm :actions, column: :action do
    state :empty, initial: true
    state :add_date_of_birth
    state :add_new_vacation
    state :remove_exist_vacation
    state :show_weather

    event :add_date_of_birth do
      transitions from: :empty, to: :add_date_of_birth
    end

    event :add_new_vacation do
      transitions from: :empty, to: :add_new_vacation
    end

    event :remove_exist_vacation do
      transitions from: :empty, to: :remove_exist_vacation
    end

    event :show_weather do
      transitions from: :empty, to: :show_weather
    end

    event :clear do
      transitions to: :empty
    end

    after_all_transitions :log_status
  end

  def validate
    super
    validates_presence [:chat_id]
    if !date_of_birth.nil?
      if (Time.now.year - date_of_birth.year) > 100 || (Time.now.year - date_of_birth.year).negative?
        errors.add(:date_of_birth, 'Дата рождения не валидная')
      end
    end
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

  def full_info
    "#{full_name} #{username} #{date_of_birth_format}"
  end

  def log_status
    Log.info "#{full_name} chanched status to #{aasm(:actions).current_event}"
  end

  def in_action?
    return false if action.nil? || action.empty?

    User.actions.include? action.to_sym
  end

  def vacations?
    vacations.any?
  end
end
