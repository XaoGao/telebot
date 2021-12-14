# frozen_string_literal: true

require 'thor'
require_relative '../helpers/utils'
require 'byebug'

module Telebot
  module Generators
    class Cli < Thor
      include Thor::Actions
      using Helpers::Utils

      desc 'generate THING NAME', 'Generate command / action / model / migration'
      def generate(thing, name)
        generate_command_method = command_by thing
        if generate_command_method.nil?
          say "Undefind #{thing} params, abort!", :red
        else
          send(generate_command_method, name)
        end
      end

      map g: :generate

      private

      def create_command(file_name)
        path = File.join('app', 'commands')
        full_name = File.join(path, "#{file_name}_command.rb")
        name = file_name.split('/').last
        create_file full_name do
          <<~COMMAND
            class #{name.to_camel_case}Command < ApplicationCommand
              # before_call :some_method
              # try         :some_method
              # when_error  :some_method
              # finally     :some_method
              # after_call  :some_method
            end
          COMMAND
        end
      end

      def create_action(file_name)
        path = File.join('app', 'commands')
        full_name = File.join(path, "#{file_name}_action.rb")
        name = file_name.split('/').last
        create_file full_name do
          <<~COMMAND
            class #{name.to_camel_case}Action < ApplicationCommand
              # before_call :some_method
              # try         :some_method
              # when_error  :some_method
              # finally     :some_method
              # after_call  :some_method
            end
          COMMAND
        end
      end

      def create_model(file_name)
        create_migration("create_#{file_name}")
        path = File.join('app', 'models')
        full_name = File.join(path, "#{file_name}.rb")
        name = file_name.split('/').last
        create_file full_name do
          <<~COMMAND
            class #{name.to_camel_case} < Sequel::Model(DB)
            end
          COMMAND
        end
      end

      def create_migration(file_name)
        path = File.join('app', 'db', 'migrations')
        existed_migrations = Dir["#{path}/*.rb"].sort
        last_migration = existed_migrations.last.split('/').last
        current_number_of_migration = next_number_of_migration(last_migration)
        migration_name = File.join(path, [current_number_of_migration, "#{file_name}.rb"].join('_'))
        create_file migration_name do
          <<~MIGRATION
            Sequel.migration do
              up do

              end

              down do

              end
            end
          MIGRATION
        end
      end

      def next_number_of_migration(migration)
        migration.nil? ? '001' : format('%03d', (migration.split('_').first.to_i + 1))
      end

      def generate_command
        {
          model: :create_model,
          command: :create_command,
          action: :create_action,
          migration: :create_migration
        }
      end

      def command_by(thing)
        generate_command[thing.downcase.to_sym]
      end
    end
  end
end
