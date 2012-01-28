require File.expand_path('../boot', __FILE__)

require 'rails/all'
require "#{File.dirname __FILE__}/../lib/active_record/html_sanitization"
require "#{File.dirname __FILE__}/../lib/active_record/assets_owner"


if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Cursame
  class Application < Rails::Application
    # config.autoload_paths += %W(#{config.root}/extras)
    # config.autoload_paths += %W(#{config.root}/lib/tabs)
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    config.time_zone = 'Mexico City'
    config.i18n.default_locale = :es
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.assets.enabled = true
    config.assets.version = '1.0'
    
    
    config.generators do |gen|
      gen.orm :active_record
      gen.test_framework :rspec, :fixture_replacement => :factory_girl, :views => false, :controllers => false  
      gen.helper = false
    end
  end
end
