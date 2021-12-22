# frozen_string_literal: true

require 'yaml'
require 'sequel'
require 'date'
require 'byebug'
require_relative '../config/initializers/telebot_initialize'

module Telebot
  module Boot
    Settings.safe_logger.info 'Booting app'

    Settings.safe_logger.info 'Connecting to DB'
    db_config_file = File.join(File.dirname(__FILE__), '..', 'app', 'db', 'database.yml')
    if File.exist?(db_config_file)
      config = YAML.safe_load(File.read(db_config_file))
      ::DB = Sequel.connect(config['development'])

      if File.exist?(File.join(File.dirname(__FILE__), '..', 'config', 'sequel_plagins.rb'))
        require_relative '../config/sequel_plagins'
      end
    end

    if File.exist?(db_config_file) && DB
      Sequel.extension :migration
      Sequel::Migrator.run(DB, File.join(File.dirname(__FILE__), '..', 'app', 'db', 'migrations'))
    end
    Settings.safe_logger.info 'Success connected to DB'

    Dir[File.join(File.dirname(__FILE__), '..', 'app', '**', '*.rb')].sort.each { |file| require file }
    Dir[File.join(File.dirname(__FILE__), '..', 'config', '**', '*.rb')].sort.each { |file| require file }
  end
end
