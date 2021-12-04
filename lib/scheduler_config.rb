# frozen_string_literal: true

class SchedulerConfig
  @@workers = []

  def self.register
    yield self
  end

  def self.add(cron_string, worker_name)
    @@workers << { cron: cron_string, worker: worker_name }
  end

  def self.workers
    @@workers
  end
end
