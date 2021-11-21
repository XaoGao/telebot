# frozen_string_literal: true

class VacationRange
  attr_reader :from, :by

  def initialize(from_str, by_str)
    @from = parse_date 'from', from_str
    @by = parse_date 'by', by_str

    raise ArgumentError, "Date 'from' more 'by' it can not be!" if @from > @by
  end

  private

  def parse_date(var_name, date_str)
    raise ArgumentError, "Date '#{var_name}' can not be nil or empty!" if date_str.nil? || date_str.empty?

    DateTime.parse date_str
  end
end
