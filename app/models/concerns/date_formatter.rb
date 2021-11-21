# frozen_string_literal: true

module DateFormatter
  def date(*args)
    args.each do |arg|
      define_method("#{arg}_format") do
        send(arg).strftime('%d.%m.%Y')
      end
    end
  end
end
