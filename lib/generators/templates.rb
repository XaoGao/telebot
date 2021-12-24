# frozen_string_literal: true

module Telebot
  module Generators
    module Templates
      class << self
        def migration
          <<~MIGRATION
            Sequel.migration do
              up do

              end

              down do

              end
            end
          MIGRATION
        end

        def model_migration(model_name)
          <<~MIGRATION
            Sequel.migration do
              up do
                create_table(:#{model_name}) do
                  primary_key :id
                end
              end

              down do
                drop_table(:#{model_name})
              end
            end
          MIGRATION
        end

        def model(model_name)
          <<~MODELNAME
            class #{model_name} < Sequel::Model(DB)
            end
          MODELNAME
        end

        def action(action_name)
          <<~ACTION
            class #{action_name}Action < ApplicationCommand
              # before_call :some_method
              # try         :some_method
              # when_error  :some_method
              # finally     :some_method
              # after_call  :some_method
            end
          ACTION
        end

        def command(command_name)
          <<~COMMAND
            class #{command_name}Command < ApplicationCommand
              # before_call :some_method
              # try         :some_method
              # when_error  :some_method
              # finally     :some_method
              # after_call  :some_method
            end
          COMMAND
        end
      end
    end
  end
end
