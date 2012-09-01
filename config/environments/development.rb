Cursame::Application.configure do
  config.action_mailer.default_url_options = { :host => 'cursame.dev:3000' }
  config.cache_classes = false
  config.whiny_nils = true
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :test
  config.active_support.deprecation = :log
  config.action_dispatch.best_standards_support = :builtin
  config.assets.compress = false
  config.assets.debug = true
  HOST = 'cursame.dev'
  HEROKU_HOST = 'cursame.dev'
end
