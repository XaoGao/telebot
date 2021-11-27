# frozen_string_literal: true

require 'yaml'
require 'sequel'
require_relative './log'
require 'byebug'
require 'date'

module Telebot
  module Boot
    Log.info 'Booting app'

    Log.info 'Connecting to DB'
    db_config_file = File.join(File.dirname(__FILE__), '..', 'app', 'db', 'database.yml')
    if File.exist?(db_config_file)
      config = YAML.safe_load(File.read(db_config_file))
      ::DB = Sequel.connect(config['development'])
      require_relative '../config/sequel_plagins'
    end

    if File.exist?(db_config_file) && DB
      Sequel::Migrator.run(DB, File.join(File.dirname(__FILE__), '..', 'app', 'db', 'migrations'))
    end
    Log.info 'Success connected to DB'

    Dir[File.join(File.dirname(__FILE__), '..', 'lib', '*.rb')].sort.each(&method(:require))
    Dir[File.join(File.dirname(__FILE__), '..', 'lib', '**', '*.rb')].sort.each(&method(:require))
    Dir[File.join(File.dirname(__FILE__), '..', 'app', '**', '*.rb')].sort.each(&method(:require))
    Dir[File.join(File.dirname(__FILE__), '..', 'config', '**', '*.rb')].sort.each(&method(:require))
  end
end
