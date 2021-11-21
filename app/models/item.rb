# frozen_string_literal: true

class Item < Sequel::Model(DB)
  def validate
    super
    validates_presence %i[name desc price image]
    validates_unique %i[name desc price image]
  end
end
