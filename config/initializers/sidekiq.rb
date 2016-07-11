require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis:6379/5', namespace: 'sidekiq.admin' }
end

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis:6379/5', namespace: 'sidekiq.admin' }
end
