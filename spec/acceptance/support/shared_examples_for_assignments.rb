shared_examples_for 'has basic actions for assignments' do
  scenario 'viewing a list of assignments' do
    assignments = (1..3).map { Factory(:assignment, :course => @course) }
    visit course_assignments_url @course, :subdomain => @network.subdomain
    assignments.each do |assignment|
      page.should show_assignment_preview assignment
    end
  end

  scenario 'viewing the detail of an assignment' do
    assignment = Factory(:assignment, :course => @course)
    visit course_assignments_path @course

    within('.assignment:last') do
      click_link assignment.name
    end
    page.should show_assignment assignment
  end
  
  scenario 'only teachers can see assignments not yet started' do
    assignments = (1..3).map { Factory(:assignment, :course => @course) }
    @assignment = Factory(:assignment, :course => @course, :start_at => 1.day.from_now)
    visit course_assignments_url @course, :subdomain => @network.subdomain
    
    assignments.each do |assignment|
      page.should show_assignment_preview assignment
    end
    if @user
      page.should_not show_assignment_preview @assignment
    else
      page.should show_assignment_preview @assignment
    end
  end
  
end
