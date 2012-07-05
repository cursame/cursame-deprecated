require 'spec_helper'

describe "stutus_courses/index" do
  before(:each) do
    assign(:stutus_courses, [
      stub_model(StutusCourse,
        :status => "",
        :course_id => 1
      ),
      stub_model(StutusCourse,
        :status => "",
        :course_id => 1
      )
    ])
  end

  it "renders a list of stutus_courses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
