# frozen_string_literal: true

require_relative './concerns/date_formatter'

class Vacation < Sequel::Model(DB)
  extend DateFormatter

  many_to_one :user

  date :from, :by

  def validate
    super
    validates_presence %i[from by]
    validates_unique %i[from by]
  end

  def interval
    "#{from_format} - #{by_format}"
  end
end
