# frozen_string_literal: true

class Order < Sequel::Model(DB)
  many_to_one :user
  many_to_one :item
end
