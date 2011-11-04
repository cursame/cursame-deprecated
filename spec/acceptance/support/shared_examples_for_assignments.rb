shared_examples_for 'has basic actions for assignments' do
  scenario 'viewing a list of assignments' do
    assignments = (1..3).map { Factory(:assignment, :course => @course) }
    visit course_assignments_url @course, :subdomain => @network.subdomain
    assignments.each do |assignment|
      page.should show_assignment_preview assignment
    end
  end

  # scenario 'viewing the detail of an assignment' do
  #   pending
  #   assignment = Factory(:assignment, :course => @course)
  #   visit course_assignments_path course
  #   within('.assignment:last') do
  #     click_link t('show_details')
  #   end
  #   page.should show_assignment assignment
  # end
end
