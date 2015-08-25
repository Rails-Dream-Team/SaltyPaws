CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV.fetch('AWS_ACCESS_KEY_ID') { 'abc' },
    aws_secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY') { '123' }
  }

  config.fog_directory  = 'salty-avatar'
end
