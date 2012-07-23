require 'spec_helper'

describe "status_courses/edit" do
  before(:each) do
    @status_course = assign(:status_course, stub_model(StatusCourse,
      :status => "MyString",
      :course_id => 1
    ))
  end

  it "renders the edit status_course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => status_courses_path(@status_course), :method => "post" do
      assert_select "input#status_course_status", :name => "status_course[status]"
      assert_select "input#status_course_course_id", :name => "status_course[course_id]"
    end
  end
end
