require 'spec_helper'

# Put your acceptance spec helpers inside spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before :each, :type => :acceptance do
    host! 'lvh.me'
    Capybara.app_host = "http://lvh.me"
  end
end
