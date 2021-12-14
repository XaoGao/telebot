# frozen_string_literal: true

require_relative '../../lib/helpers/utils'

class RefineStringClass
  using Telebot::Helpers::Utils

  attr_accessor :str

  def initialize(str)
    @str = str
  end

  def snake_case
    str.to_snake_case
  end

  def camel_case
    str.to_camel_case
  end
end
