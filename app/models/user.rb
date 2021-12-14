# frozen_string_literal: true

class User < Sequel::Model(DB)
  include DateFormatter
  include UserAasm

  one_to_many :vacations

  pretty_date_format_for :date_of_birth

  def validate
    super
    validates_presence [:chat_id]
    errors.add(:date_of_birth, 'Дата рождения не валидная') if date_of_birth_invalid?
  end

  def self.actions
    default_state = User.aasm(:actions).initial_state
    aasm(:actions).states.map(&:name).filter { |a| a != default_state }
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

  def full_info
    date = date_of_birth.nil? ? '' : date_of_birth_format

    "#{full_name} #{username} #{date}"
  end

  def in_action?
    return false if action.nil? || action.empty?

    User.actions.include? action.to_sym
  end

  def vacations?
    vacations.any?
  end

  private

  def date_of_birth_invalid?
    !date_of_birth.nil? && (year_of_date_of_birth_to_mach? || year_of_date_of_birth_negative?)
  end

  def year_of_date_of_birth_to_mach?
    (Time.now.year - date_of_birth.year) > 100
  end

  def year_of_date_of_birth_negative?
    (Time.now.year - date_of_birth.year).negative?
  end
end
