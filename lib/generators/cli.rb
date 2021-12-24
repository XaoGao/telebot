# frozen_string_literal: true

require 'thor'
require_relative '../helpers/utils'
require_relative './templates'

module Telebot
  module Generators
    class Cli < Thor
      include Thor::Actions
      using Helpers::Utils

      desc 'generate THING NAME', 'Generate command / action / model / migration'
      def generate(thing, name)
        generate_method = generate_by thing
        if generate_method.nil?
          say "Undefind #{thing} params, abort!", :red
        else
          send(generate_method, name)
        end
      end

      private

      def create_command(file_name)
        path = File.join('app', 'commands')
        full_name = File.join(path, "#{file_name}_command.rb")
        name = file_name.split('/').last.to_camel_case
        create_file full_name do
          Templates.command(name)
        end
      end

      def create_action(file_name)
        path = File.join('app', 'commands')
        full_name = File.join(path, "#{file_name}_action.rb")
        name = file_name.split('/').last.to_camel_case
        create_file full_name do
          Templates.action(name)
        end
      end

      def create_model(file_name)
        create_migration("create_#{file_name}", true)
        path = File.join('app', 'models')
        full_name = File.join(path, "#{file_name}.rb")
        name = file_name.split('/').last.to_camel_case
        create_file full_name do
          Templates.model(name)
        end
      end

      def create_migration(file_name, for_model = false)
        path = File.join('app', 'db', 'migrations')
        existed_migrations = Dir["#{path}/*.rb"].sort
        last_migration = existed_migrations.last.split('/').last
        current_number_of_migration = next_number_of_migration(last_migration)
        migration_name = File.join(path, [current_number_of_migration, "#{file_name}.rb"].join('_'))
        model_name = file_name.sub('create_', '').to_snake_case
        create_file migration_name do
          for_model ? Templates.model_migration(model_name) : Templates.migration
        end
      end

      def next_number_of_migration(migration)
        migration.nil? ? '001' : format('%03d', (migration.split('_').first.to_i + 1))
      end

      def generate_list
        {
          model: :create_model,
          command: :create_command,
          action: :create_action,
          migration: :create_migration
        }
      end

      def generate_by(thing)
        generate_list[thing.downcase.to_sym]
      end
    end
  end
end
