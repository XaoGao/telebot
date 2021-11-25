# frozen_string_literal: true

require 'aasm'

module UserAasm
  def self.included(base)
    base.class_eval do
      include AASM
      aasm :actions, column: :action do
        state :empty, initial: true
        state :choose_city
        state :choose_gender
        state :set_date_of_birth
        state :update_date_of_birth
        state :add_new_vacation
        state :remove_exist_vacation
        state :show_weather
        state :choose_item

        event :choose_city do
          transitions from: :empty, to: :choose_city
        end

        event :choose_gender do
          transitions from: :choose_city, to: :choose_gender
        end

        event :set_date_of_birth do
          transitions from: :choose_gender, to: :set_date_of_birth
        end

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

        event :close_command do
          transitions to: :empty
        end

        # after_all_transitions :log_status
      end

      # def log_status
      #   Log.info "#{full_name} chanched status to #{aasm(:actions).to_state}"
      # end
    end
  end
end
