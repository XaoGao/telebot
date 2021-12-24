# frozen_string_literal: true

require 'logger'

class NilLogger < Logger
  def initialize(*); end

  def add(*); end
end
