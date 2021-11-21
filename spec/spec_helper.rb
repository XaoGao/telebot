# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'yaml'
require 'sequel'
require 'factory_bot'
require 'database_cleaner-sequel'
require_relative './support/helper_methods'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include FactoryBot::Syntax::Methods

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.before do
    DatabaseCleaner[:sequel].strategy = :transaction
  end

  config.before do
    DatabaseCleaner[:sequel].start
  end

  config.after do
    DatabaseCleaner[:sequel].clean
  end

  config.include HelperMethods
end

db_config_file = File.join(File.dirname(__FILE__), '..', 'app', 'db', 'database.yml')
if File.exist?(db_config_file)
  config = YAML.safe_load(File.read(db_config_file))
  DB = Sequel.connect(config['test'])
  Sequel::Model.plugin :timestamps, create: :created_on, update: :updated_on, update_on_create: true
  Sequel::Model.plugin :touch
  Sequel::Model.plugin :validation_helpers
  Sequel.extension :migration
end

if DB
  Sequel::Migrator.run(DB, File.join(File.dirname(__FILE__), '..', 'app', 'db', 'migrations'))

  require_relative '../app/models/user'
  require_relative '../app/models/vacation'
  require_relative '../app/models/vacation_range'
  require_relative '../lib/command_factory'
  require_relative '../lib/router'
  require_relative '../lib/bot_action'
  require_relative '../lib/command'
  require_relative '../lib/nil_command'
  require_relative '../lib/string'
  require_relative './support/dump_command'
  require_relative './support/dump_action'
end
