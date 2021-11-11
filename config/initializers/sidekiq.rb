require 'sidekiq'

Sidekiq.confiqure_client do |config|
  config.redis = { url: '127.0.0.1:6379' }
end

Sidekiq.confiqure_server do |config|
  config.redis = { url: '127.0.0.1:6379' }
end
