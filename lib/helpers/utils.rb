module Telebot
  module Helpers
    module Utils
      refine String do
        def to_snake_case
          gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
            .gsub(/([a-z\d])([A-Z])/, '\1_\2')
            .tr('-', '_')
            .gsub(/\s/, '_')
            .gsub(/__+/, '_')
            .downcase
        end

        def to_camel_case
          split('_').map(&:capitalize).join
        end
      end
    end
  end
end
