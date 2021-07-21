require 'yaml'
require 'sequel'
require 'factory_bot'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end

db_config_file = File.join(File.dirname(__FILE__), '..', 'app', 'db', 'database.yml')
if File.exist?(db_config_file)
  config = YAML.safe_load(File.read(db_config_file))
  DB = Sequel.connect(config['test'])
  Sequel::Model.plugin :timestamps, create: :created_on, update: :updated_on, update_on_create: true
  Sequel.extension :migration
end

if DB
  Sequel::Migrator.run(DB, File.join(File.dirname(__FILE__), '..', 'app', 'db', 'migrations'))
end

