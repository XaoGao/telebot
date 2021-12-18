# frozen_string_literal: true

require 'yaml'
require 'sequel'
require 'date'
require 'i18n'
require 'byebug'

module Telebot
  module Boot
    Dir[File.join(File.dirname(__FILE__), '..', 'lib', 'settings.rb')].sort.each { |file| require file }
    Dir[File.join(File.dirname(__FILE__), '..', 'config', 'initializers', 'telebot_initialize.rb')].sort.each { |file| require file }

    Settings.logger.info 'Booting app'

    Settings.logger.info 'Connecting to DB'
    db_config_file = File.join(File.dirname(__FILE__), '..', 'app', 'db', 'database.yml')
    if File.exist?(db_config_file)
      config = YAML.safe_load(File.read(db_config_file))
      ::DB = Sequel.connect(config['development'])
      require_relative '../config/sequel_plagins'
    end

    if File.exist?(db_config_file) && DB
      Sequel::Migrator.run(DB, File.join(File.dirname(__FILE__), '..', 'app', 'db', 'migrations'))
    end
    Settings.logger.info 'Success connected to DB'

    Settings.logger.info 'Loading locales'

    I18n.load_path << Settings.default_locale_load_paths
    I18n.default_locale = Settings.default_locale

    Settings.logger.info 'Locales loaded'

    Dir[File.join(File.dirname(__FILE__), '..', 'lib', '*.rb')].sort.each { |file| require file }
    Dir[File.join(File.dirname(__FILE__), '..', 'lib', '**', '*.rb')].sort.each { |file| require file }
    Dir[File.join(File.dirname(__FILE__), '..', 'app', '**', '*.rb')].sort.each { |file| require file }
    Dir[File.join(File.dirname(__FILE__), '..', 'config', '**', '*.rb')].sort.each { |file| require file }
  end
end
