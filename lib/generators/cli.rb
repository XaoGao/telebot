require 'thor'

module Telebot
  module Generators
    class Cli < Thor
      include Thor::Actions

      desc 'create_command FILE_NAME', 'Create a new file in dir commands'
      def create_command(file_name)
        puts "Create #{file_name}"
      end

      desc 'create_action FILE_NAME', 'Create a new file in dir actions'
      def create_action(file_name)
        puts "Create #{file_name}"
      end

      desc 'create_model FILE_NAME', 'Create a new file in dir models'
      def create_model(file_name)
        puts "Create #{file_name}"
      end

      desc 'create_migration FILE_NAME', 'Create a new file in dir migrations'
      def create_migration(file_name)
        puts "Create #{file_name}"
      end
    end
  end
end
