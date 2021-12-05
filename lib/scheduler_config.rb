# frozen_string_literal: true

class SchedulerConfig
  class << self
    attr_accessor :workers
  end

  def self.register
    @workers ||= []
    yield self
  end

  def self.add(cron_string, worker_name)
    @workers << { cron: cron_string, worker: worker_name }
  end
end
