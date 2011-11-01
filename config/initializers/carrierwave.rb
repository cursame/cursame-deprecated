CarrierWave.configure do |config|
  # config.s3_access_key_id     = "x" 
  # config.s3_secret_access_key = "x" 
  # config.s3_bucket            = "x"
  config.storage(Rails.env.test? || Rails.env.development? ? :file : :s3) 
end

CarrierWave.configure do |config|
  config.root      = Rails.root.join('tmp')
  config.cache_dir = 'uploads'
end

Rails.configuration.middleware.delete('Sass::Plugin::Rack')
Rails.configuration.middleware.insert_before('Rack::Sendfile', 'Sass::Plugin::Rack')
Rails.configuration.middleware.insert_before('Rack::Sendfile', 'Rack::Static', :urls => ['/uploads'], :root => 'tmp')
