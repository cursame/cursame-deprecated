require 'spec_helper'

describe "status_courses/show" do
  before(:each) do
    @status_course = assign(:status_course, stub_model(StatusCourse,
      :status => "Status",
      :course_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Status/)
    rendered.should match(/1/)
  end
end
