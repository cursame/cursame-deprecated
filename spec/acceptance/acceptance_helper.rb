require 'spec_helper'
require "selenium-webdriver"

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Capybara.app_host     = "lvh.me"
Capybara.default_host = "subdomain.lvh.me"
Capybara.server_port  = 7335

RSpec.configure do |config|
  config.before :each, :type => :acceptance do
    Capybara.current_driver = :selenium if example.metadata[:js]

    if Capybara.current_driver == :rack_test
      host! 'lvh.me'
      Capybara.app_host = "http://lvh.me"
    else
      host! "lvh.me:7335"
    end
  end
  
  config.after do
    Capybara.use_default_driver if example.metadata[:js]
  end
end
