require 'spec_helper'

describe "stutus_courses/edit" do
  before(:each) do
    @stutus_course = assign(:stutus_course, stub_model(StutusCourse,
      :status => "",
      :course_id => 1
    ))
  end

  it "renders the edit stutus_course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stutus_courses_path(@stutus_course), :method => "post" do
      assert_select "input#stutus_course_status", :name => "stutus_course[status]"
      assert_select "input#stutus_course_course_id", :name => "stutus_course[course_id]"
    end
  end
end
