shared_examples_for 'has basic actions for assignments' do
  scenario 'viewing a list of assignments' do
    assignments = (1..3).map { Factory(:assignment, :course => @course) }
    (1..3).map { assignments << Factory(:published_assignment, :course => @course) }
    (1..3).map { assignments << Factory(:published_finished_assignment, :course => @course) }
    visit course_assignments_url @course, :subdomain => @network.subdomain
    
    assignments.each do |assignment|
      page.should show_assignment_preview assignment if assignment.published? and !assignment.expired?
    end
    
    click_link 'Cerradas'
    
    assignments.each do |assignment|
      page.should show_assignment_preview assignment if assignment.published? and assignment.expired?
    end
    
    if @teacher
      
      click_link 'No publicadas'
    
      assignments.each do |assignment|
        page.should show_assignment_preview assignment unless assignment.published?
      end
    end
    
    #TODO: Test the tabs for finished and non published assignments
    
  end

  scenario 'viewing the detail of an assignment', :js => true do
    assignment = Factory(:published_assignment, :course => @course)
    visit course_assignments_url(@course, :subdomain => @network.subdomain)

    within('.assignment:last') do
      click_link assignment.name
    end
    page.should show_assignment assignment
  end
  
  scenario 'only teachers can see assignments not yet started' do
    assignments = (1..3).map { Factory(:published_assignment, :course => @course) }
    @assignment = Factory(:assignment, :course => @course)
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
