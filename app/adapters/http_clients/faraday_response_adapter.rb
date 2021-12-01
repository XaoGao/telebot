# frozen_string_literal: true

class FaradayResponseAdapter
  attr_reader :response

  def initialize(response)
    @response = response
  end

  def status
    response.status
  end

  def body
    response.body
  end
end
