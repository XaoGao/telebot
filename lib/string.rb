class String
  def to_snake_case
    self.gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
        .gsub(/([a-z\d])([A-Z])/, '\1_\2')
        .tr('-', '_')
        .gsub(/\s/, '_')
        .gsub(/__+/, '_')
        .downcase
  end

  def to_camel_case
    self.split('_').map { |x| x.capitalize }.join
  end
end
