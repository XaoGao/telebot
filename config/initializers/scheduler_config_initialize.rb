# frozen_string_literal: true

SchedulerConfig.register do |scheduler_table|
  scheduler_table.add '* * * * 1', '1111MyJobWorker'
  scheduler_table.add '* * * * 2', '222MyJobWorker'
end
