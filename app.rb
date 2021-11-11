# require './lib/boot'
require './main'

class App
  def call(env)
    [200, { 'Content-Type' => 'text/html' }, ['Hello Rack Participants']]
  end
end
