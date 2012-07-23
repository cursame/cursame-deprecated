require 'spec_helper'

describe "calendar_activities/show" do
  before(:each) do
    @calendar_activity = assign(:calendar_activity, stub_model(CalendarActivity,
      :name => "Name",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
  end
end
