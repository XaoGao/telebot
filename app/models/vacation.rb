require_relative './concerns/date_formatter'

class Vacation < Sequel::Model(DB)
  extend DateFormatter

  plugin :timestamps, update_on_create: true

  many_to_one :user

  date :from, :by

  def interval
    "#{from_format} - #{by_format}"
  end
end
