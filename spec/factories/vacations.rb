# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  to_create(&:save)
  factory :vacation do
    from { Faker::Time.between(from: DateTime.now - 4, to: DateTime.now - 3) }
    by { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now - 1) }
    # association :user
    user { FactoryBot.create(:user) }
  end
end
