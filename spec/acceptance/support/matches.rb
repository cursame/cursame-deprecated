RSpec::Matchers.define :have_notice do |expected|
  match do |page|
    page.should have_css '.alert-message.notice', :text => expected
  end
end

RSpec::Matchers.define :have_error do |expected|
  match do |page|
    page.should have_css '.alert-message.error', :text => expected
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
    page.should have_content Sanitize.clean(assignment.description).strip
    page.should have_content assignment.value
    page.should have_content assignment.period
    page.should have_content I18n.l(assignment.due_to, :format => :short) 
  end
end

RSpec::Matchers.define :show_assignment_preview do |assignment|
  match do |page|
    page.should have_content assignment.course.name
    page.should have_content assignment.name
    page.should have_content assignment.value
    page.should have_content assignment.period
    page.should have_content I18n.l(assignment.due_to, :format => :short) 

    page.should have_css "a[href='#{assignment_path assignment}']"
  end
end

RSpec::Matchers.define :show_comment do |comment|
  match do |page|
    page.should have_css "#comment_#{comment.id}"
    within "#comment_#{comment.id}" do
      page.should have_content comment.user.name
      page.should have_content Sanitize.clean(comment.text).strip 
    end
  end
end

RSpec::Matchers.define :show_course do |course|
  match do |page|
    page.should have_content course.name
    page.should have_content Sanitize.clean(course.description).strip
  end
end

RSpec::Matchers.define :show_discussion do |discussion|
  match do |page|
    page.should have_content discussion.title
    page.should have_content Sanitize.clean(discussion.description).strip
  end
end

RSpec::Matchers.define :show_discussion_preview do |discussion|
  match do |page|
    page.should have_css "a[href='#{discussion_path discussion}']", :text => discussion.title
  end
end
