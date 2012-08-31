CarrierWave.configure do |config|
  config.s3_access_key_id     = "AKIAISIGOKLLQ6T5H3NQ" 
  config.s3_secret_access_key = "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" 
  #config.s3_bucket            = "cursame-#{Rails.env}"
  config.s3_bucket            = "cursame-staging"
  config.storage(Rails.env.test? || Rails.env.development? ? :file : :s3) 
  config.s3_headers = {"Content-Disposition" => "attachment"}
end

CarrierWave.configure do |config|
  config.root      = Rails.root.join('tmp')
  config.cache_dir = 'uploads/cached-carrierwave'
end

Rails.configuration.middleware.delete('Sass::Plugin::Rack')
Rails.configuration.middleware.insert_before('Rack::Sendfile', 'Sass::Plugin::Rack')
Rails.configuration.middleware.insert_before('Rack::Sendfile', 'Rack::Static', :urls => ['/uploads'], :root => 'tmp')
