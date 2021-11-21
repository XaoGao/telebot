# frozen_string_literal: true

require 'sidekiq'

class MyJobWorker
  include Sidekiq::Worker

  def perform(_args)
    p 'test'
  end
end
