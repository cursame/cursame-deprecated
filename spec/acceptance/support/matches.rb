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

 failure_message_for_should do |model|
    "expected a #{model} with:\n\n#{attributes.inspect}\n\nto exist within\n\n#{model.all.map { |m| m.attributes }.inspect}"
  end

  failure_message_for_should_not do |model|
    "expected a #{model.class} with #{attributes.inspect} not to exist"
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
    page.should have_content assignment.value.to_s
    page.should have_content assignment.period.to_s
    page.should have_content I18n.l(assignment.due_to, :format => :short) 

    # page.should have_css "a[href='#{assignment_path assignment}']"
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

RSpec::Matchers.define :show_user do |user|
  match do |page|
    page.should have_content user.name
    page.should have_content user.about_me
    page.should have_content user.studies
    page.should have_content user.occupation
  end
end

RSpec::Matchers.define :show_delivery do |delivery|
  match do |page|
    page.should have_content Sanitize.clean(delivery.content).strip
    page.should have_content I18n.l(delivery.updated_at, :format => :short) 
    page.should have_content delivery.user.name
    page.should show_assignment_preview delivery.assignment
  end
end

RSpec::Matchers.define :show_delivery_preview do |delivery|
  match do |page|
    page.should have_css '.delivery'
    within '.delivery' do
      page.should have_content I18n.l(delivery.updated_at, :format => :short) 
    end
    page.should have_content delivery.user.name # TODO: WTF, por que estoy no puede ir dentro de within block?
  end
end

RSpec::Matchers.define :link_to do |link|
  match do |page|
    page.should have_css %{a[href$="#{link}"]}
  end
end

RSpec::Matchers.define :show_survey_preview do |survey|
  match do |page|
    page.should have_content survey.course.name
    page.should have_content survey.name
    page.should have_content survey.value.to_s
    page.should have_content survey.period.to_s
    page.should have_content I18n.l(survey.due_to, :format => :short) 
  end
end

RSpec::Matchers.define :show_survey_full_preview do |survey|
  match do |page|
    page.should have_content survey.course.name
    page.should have_content survey.name
    page.should have_content survey.value.to_s
    page.should have_content survey.period.to_s
    page.should have_content I18n.l(survey.due_to, :format => :short)

    survey.questions.each { |q| page.should show_question_preview q }
  end
end

RSpec::Matchers.define :show_question_preview do |question|
  match do |page|
    page.should have_content question.text
    question.answers.each { |a| page.should show_answer_preview a }
  end
end

RSpec::Matchers.define :show_answer_preview do |answer|
  match do |page|
    page.should have_content answer.text
  end
end

RSpec::Matchers.define :show_survey_reply do |survey_reply|
  match do |page|
    survey_reply.survey_answers.each do |survey_answer|
      question = survey_answer.question
      page.should have_content question.text
      page.should have_checked_field survey_answer.answer.text
    end
    page.should show_survey_preview survey_reply.survey
  end
end
