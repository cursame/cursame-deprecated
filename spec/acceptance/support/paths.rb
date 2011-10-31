module NavigationHelpers
  include Cursame::Application.routes.url_helpers
end

RSpec.configuration.include NavigationHelpers, :type => :acceptance
