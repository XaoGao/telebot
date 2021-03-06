# frozen_string_literal: true

module DateFormatter
  def self.included(base)
    base.send(:extend, ClassMethods)
  end

  module ClassMethods
    def pretty_date_format_for(*args)
      args.each do |arg|
        define_method("#{arg}_format") do
          send(arg).strftime('%d.%m.%Y')
        end
      end
    end
  end
end
