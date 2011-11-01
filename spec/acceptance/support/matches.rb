RSpec::Matchers.define :have_notice do |expected|
  match do |page|
    page.should have_css '.flash.notice', :text => expected
  end
end
