Cursame::Application.configure do
  HOST = 'labbbs.net'
  HEROKU_HOST = 'young-samurai-3345.herokuapp.com'
  config.cache_classes = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = false
  config.assets.compress = true
  config.assets.compile = false
  config.assets.digest = true
  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH
  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx
  # config.force_ssl = true
  config.log_level = :debug
  # config.logger = SyslogLogger.new
  # config.cache_store = :mem_cache_store
  # config.action_controller.asset_host = "http://assets.example.com"
  # config.assets.precompile += %w( search.js )
  # config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { :host => HOST }
  # config.threadsafe!
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => 'heroku.com'
  }
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.default :from => "Cursame <noreply@cursa.me>"
end
