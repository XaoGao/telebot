# frozen_string_literal: true

require 'yaml'
require 'sequel'
require_relative './log'
require 'byebug'
require 'date'

Log.info 'Boot app'

db_config_file = File.join(File.dirname(__FILE__), '..', 'app', 'db', 'database.yml')
if File.exist?(db_config_file)
  config = YAML.safe_load(File.read(db_config_file))
  DB = Sequel.connect(config['development'])
  Sequel::Model.plugin :timestamps, create: :created_on, update: :updated_on, update_on_create: true
  Sequel::Model.plugin :touch
  Sequel::Model.plugin :validation_helpers
  Sequel.extension :migration
end

if File.exist?(db_config_file) && DB
  Sequel::Migrator.run(DB, File.join(File.dirname(__FILE__), '..', 'app', 'db', 'migrations'))
end

Dir[File.join(File.dirname(__FILE__), '..', 'lib', '*.rb')].sort.each(&method(:require))
Dir[File.join(File.dirname(__FILE__), '..', 'lib', '**', '*.rb')].sort.each(&method(:require))
Dir[File.join(File.dirname(__FILE__), '..', 'app', '**', '*.rb')].sort.each(&method(:require))
Dir[File.join(File.dirname(__FILE__), '..', 'config', '**', '*.rb')].sort.each(&method(:require))
