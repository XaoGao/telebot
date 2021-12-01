# frozen_string_literal: true

require 'faraday'
require_relative './faraday_response_adapter'

class FaradayClientAdapter
  attr_reader :faraday_client

  def initialize
    @faraday_client = Faraday
  end

  def get(url)
    FaradayResponseAdapter.new(faraday_client.get(url))
  end
end
