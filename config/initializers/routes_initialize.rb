# frozen_string_literal: true

require 'yaml'

ROUTES = YAML.safe_load(File.read(File.join(File.dirname(__FILE__), '..', '..', 'app', 'routes.yml')))
