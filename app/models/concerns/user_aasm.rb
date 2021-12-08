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

        event :status_to_choose_city do
          transitions from: :empty, to: :choose_city
        end

        event :status_to_choose_gender do
          transitions from: :choose_city, to: :choose_gender
        end

        event :status_to_set_date_of_birth do
          transitions from: :choose_gender, to: :set_date_of_birth
        end

        event :status_to_update_date_of_birth do
          transitions from: :empty, to: :update_date_of_birth
        end

        event :status_to_add_new_vacation do
          transitions from: :empty, to: :add_new_vacation
        end

        event :status_to_remove_exist_vacation do
          transitions from: :empty, to: :remove_exist_vacation
        end

        event :status_to_show_weather do
          transitions from: :empty, to: :show_weather
        end

        event :status_to_choose_item do
          transitions from: :empty, to: :choose_item
        end

        event :close_command do
          transitions to: :empty
        end
      end
    end
  end
end
