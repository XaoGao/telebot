require 'aasm'

module UserAasm
  def self.included(base)
    base.class_eval do
      include AASM
      aasm :actions, column: :action do
        state :empty, initial: true
        state :update_date_of_birth

        event :update_date_of_birth do
          transitions from: :empty, to: :update_date_of_birth
        end

        event :clear do
          transitions to: :empty
        end
      end
    end
  end
end
