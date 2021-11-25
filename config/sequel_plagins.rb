# frozen_string_literal: true

require 'sequel'

Sequel::Model.plugin :timestamps, create: :created_on, update: :updated_on, update_on_create: true
Sequel::Model.plugin :touch
Sequel::Model.plugin :validation_helpers
Sequel.extension :migration
