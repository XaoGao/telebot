# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  to_create(&:save)
  factory :user do
    first_name { Faker::Name.first_name }
    last_name {  Faker::Name.last_name }
    username { Faker::Internet.username }
    chat_id { Faker::IDNumber.croatian_id }
    date_of_birth { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
  end
end
