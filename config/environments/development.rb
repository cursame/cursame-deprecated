Cursame::Application.configure do
  config.action_mailer.default_url_options = { :host => 'lvh.me:3000' }
  config.cache_classes = false
  config.whiny_nils = true
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.action_dispatch.best_standards_support = :builtin
  config.assets.compress = false
  config.assets.debug = true
  HOST = 'lvh.me'
  HEROKU_HOST = 'lvh.me'
end
