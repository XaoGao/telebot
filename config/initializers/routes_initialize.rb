require 'yaml'

ROUTES = YAML.load(File.read(File.join(File.dirname(__FILE__), '..', '..', 'app', 'routes.yml')))
