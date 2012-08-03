Cursame::Application.configure do
  HOST = 'cursatest.com'
  HEROKU_HOST = 'cursatest.heroku.com'
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
      :address        => '50.116.21.144',
      :port           => '25',
      :authentication => :true,
      :user_name      => 'wichobabas',
      :password       => 'qor43e95',
      :domain         => '50.116.21.144'
  }
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.default :from => "Cursame <noreply@cursa.me>"
end
