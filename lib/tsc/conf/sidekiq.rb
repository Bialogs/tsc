redis = ENV.fetch('TSC_REDIS_URL') { 'redis://localhost:6379' }

Sidekiq.configure_server do |config|
  config.redis = { url: redis }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis }
end
