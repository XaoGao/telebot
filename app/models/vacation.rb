require_relative './concerns/date_formatter'

class Vacation < Sequel::Model(DB)
  extend DateFormatter

  many_to_one :user

  date :from, :by

  def validate
    super
    validates_presence [:from, :by]
    validates_unique [:from, :by]
  end

  def interval
    "#{from_format} - #{by_format}"
  end
end
