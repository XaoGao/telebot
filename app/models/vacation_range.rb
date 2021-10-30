class VacationRange
  attr_reader :from, :by

  def initialize(from_str, by_str)
    @from = parse_date 'from', from_str
    @by = parse_date 'by', by_str

    if @from > @by
      raise ArgumentError "Date 'from' more 'by' it can not be!"
    end
  end

  private

  def parse_date(var_name, date_str)
    if date_str.nil? || date_str.empty?
      raise ArgumentError "Date '#{var_name}' can not be nil or empty!"
    end

    DateTime.parse date_str
  end
end
