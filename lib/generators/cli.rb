require 'thor'

module Telebot
  module Generators
    class Cli < Thor
      include Thor::Actions

      desc 'command FILE_NAME', 'Create a new file in dir commands'
      def command(file_name)
        puts "Create #{file_name}"
      end

      desc 'action FILE_NAME', 'Create a new file in dir actions'
      def action(file_name)
        puts "Create #{file_name}"
      end

      desc 'model FILE_NAME', 'Create a new file in dir models'
      def model(file_name)
        puts "Create #{file_name}"
      end

      desc 'migration FILE_NAME', 'Create a new file in dir migrations'
      def migration(file_name)
        puts "Create #{file_name}"
      end
    end
  end
end
