# frozen_string_literal: true

require './main'

class App
  def call(_env)
    [200, { 'Content-Type' => 'text/html' }, ['Hello Rack Participants']]
  end
end
