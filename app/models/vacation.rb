# frozen_string_literal: true

class Vacation < Sequel::Model(DB)
  include DateFormatter

  many_to_one :user

  pretty_date_format_for :from, :by

  def validate
    super
    validates_presence %i[from by]
    validates_unique %i[from by]
  end

  def interval
    "#{from_format} - #{by_format}"
  end
end
