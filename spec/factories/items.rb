# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  to_create(&:save)
  factory :item do
    name { Faker::Coffee.blend_name }
    desc { Faker::Coffee.notes }
    price { Faker::Number.decimal(l_digits: 2) }
    image { 'test.jpg' }
  end
end
