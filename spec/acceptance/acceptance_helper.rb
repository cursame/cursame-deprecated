require 'spec_helper'
require "selenium-webdriver"

# Put your acceptance spec helpers inside spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Capybara.app_host     = "lvh.me"
Capybara.default_host = "subdomain.lvh.me"
Capybara.server_port  = 7335

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before :each do
    Capybara.current_driver = :selenium if example.metadata[:js]
    if Capybara.current_driver == :rack_test
      DatabaseCleaner.strategy = :transaction
    else
      host! "lvh.me:7335"
      DatabaseCleaner.strategy = :truncation
    end
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
    Capybara.use_default_driver if example.metadata[:js]
  end
end
