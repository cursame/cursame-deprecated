require 'spec_helper'

describe "stutus_courses/show" do
  before(:each) do
    @stutus_course = assign(:stutus_course, stub_model(StutusCourse,
      :status => "",
      :course_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/1/)
  end
end
