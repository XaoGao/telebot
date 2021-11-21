# frozen_string_literal: true

require 'aasm'

module UserAasm
  def self.included(base)
    base.class_eval do
      include AASM
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

        event :close_command do
          transitions to: :empty
        end
      end
    end
  end
end
