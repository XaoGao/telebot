require 'aasm'
require_relative './concerns/date_formatter'

class User < Sequel::Model(DB)
  include AASM
  extend DateFormatter

  one_to_many :vacations

  date :date_of_birth

  aasm :actions, column: :action do
    state :empty, initial: true
    state :update_date_of_birth
    state :add_new_vacation
    state :remove_exist_vacation
    state :show_weather
    state :choose_item

    event :update_date_of_birth do
      transitions from: :empty, to: :update_date_of_birth
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

    event :choose_item do
      transitions from: :empty, to: :choose_item
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
    date = if !date_of_birth.nil?
             date_of_birth_format
           else
             ''
           end

    "#{full_name} #{username} #{date}"
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
