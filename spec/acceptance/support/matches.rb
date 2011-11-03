RSpec::Matchers.define :have_notice do |expected|
  match do |page|
    page.should have_css '.flash.notice', :text => expected
  end
end

RSpec::Matchers.define :exist_with do |attributes|
  match do |model|
    model.where(attributes).count.should be > 0
  end
end

RSpec::Matchers.define :show_assignment do |assignment|
  match do |page|
    page.should have_content Assignment.model_name.human

    page.should have_content assignment.course.name
    page.should have_content assignment.name
    page.should have_content assignment.description
    page.should have_content assignment.value
    page.should have_content assignment.period
    page.should have_content I18n.l(assignment.due_to, :format => :short) 
  end
end
