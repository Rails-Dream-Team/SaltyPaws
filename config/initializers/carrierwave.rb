CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV.fetch('AWS_ACCESS_KEY_ID') { 'abc' },
    aws_secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY') { 'xyz' }
  }

  config.fog_directory  = 'salty-avatar'

  config.cache_dir = "#{Rails.root}/tmp/uploads"
end
