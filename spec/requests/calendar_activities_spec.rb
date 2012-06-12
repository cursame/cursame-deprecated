require 'spec_helper'

describe "CalendarActivities" do
  describe "GET /calendar_activities" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get calendar_activities_path
      response.status.should be(200)
    end
  end
end
