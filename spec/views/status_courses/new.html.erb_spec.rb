require 'spec_helper'

describe "status_courses/new" do
  before(:each) do
    assign(:status_course, stub_model(StatusCourse,
      :status => "MyString",
      :course_id => 1
    ).as_new_record)
  end

  it "renders new status_course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => status_courses_path, :method => "post" do
      assert_select "input#status_course_status", :name => "status_course[status]"
      assert_select "input#status_course_course_id", :name => "status_course[course_id]"
    end
  end
end
