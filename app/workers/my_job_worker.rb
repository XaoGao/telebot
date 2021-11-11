require 'sidekiq'

class MyJobWorker
  include Sidekiq::Worker

  def perform(args)
    p 'test'
  end
end
