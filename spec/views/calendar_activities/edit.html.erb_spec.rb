require 'spec_helper'

describe "calendar_activities/edit" do
  before(:each) do
    @calendar_activity = assign(:calendar_activity, stub_model(CalendarActivity,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit calendar_activity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => calendar_activities_path(@calendar_activity), :method => "post" do
      assert_select "input#calendar_activity_name", :name => "calendar_activity[name]"
      assert_select "textarea#calendar_activity_description", :name => "calendar_activity[description]"
    end
  end
end
