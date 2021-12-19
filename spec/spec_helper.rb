# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'yaml'
require 'sequel'
require 'factory_bot'
require 'database_cleaner-sequel'
require 'telegram/bot'
require_relative './support/helper_methods'
require_relative './support/configure/data_base_cleaner'

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

  config.include HelperMethods
end

db_config_file = File.join(File.dirname(__FILE__), '..', 'app', 'db', 'database.yml')
if File.exist?(db_config_file)
  config = YAML.safe_load(File.read(db_config_file))
  DB = Sequel.connect(config['test'])

  if File.exist?(File.join(File.dirname(__FILE__), '..', 'config', 'sequel_plagins.rb'))
    require_relative '../config/sequel_plagins'
  end
end

if DB
  Sequel.extension :migration
  Sequel::Migrator.run(DB, File.join(File.dirname(__FILE__), '..', 'app', 'db', 'migrations'))

  require_relative '../app/models/concerns/date_formatter'
  require_relative '../app/models/concerns/file_uploadable'
  require_relative '../app/models/concerns/user_aasm'
  require_relative '../app/models/user'
  require_relative '../app/models/vacation'
  require_relative '../app/models/vacation_range'
  require_relative '../lib/services/find_user_service'
  require_relative '../lib/commands/command_factory'
  require_relative '../lib/router'
  require_relative '../lib/helpers/bot_action'
  require_relative '../lib/commands/command_base'
  require_relative '../lib/commands/nil_command'
  require_relative '../lib/helpers/utils'
  require_relative './support/dump_command'
  require_relative './support/dump_action'
end
