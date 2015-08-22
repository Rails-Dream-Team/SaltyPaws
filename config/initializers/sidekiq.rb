# Rails.env.production? ? redis_url = ENV['REDIS_URL'] : redis_url = 'http://localhost:3000'
#
# Sidekiq.configure_server do |config|
#   config.redis = { url: ENV.fetch('REDIS_URL') }
# end
#
# Sidekiq.configure_client do |config|
#   config.redis = { url: ENV.fetch('REDIS_URL') }
# end
