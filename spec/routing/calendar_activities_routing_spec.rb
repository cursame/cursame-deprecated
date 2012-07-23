require "spec_helper"

describe CalendarActivitiesController do
  describe "routing" do

    it "routes to #index" do
      get("/calendar_activities").should route_to("calendar_activities#index")
    end

    it "routes to #new" do
      get("/calendar_activities/new").should route_to("calendar_activities#new")
    end

    it "routes to #show" do
      get("/calendar_activities/1").should route_to("calendar_activities#show", :id => "1")
    end

    it "routes to #edit" do
      get("/calendar_activities/1/edit").should route_to("calendar_activities#edit", :id => "1")
    end

    it "routes to #create" do
      post("/calendar_activities").should route_to("calendar_activities#create")
    end

    it "routes to #update" do
      put("/calendar_activities/1").should route_to("calendar_activities#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/calendar_activities/1").should route_to("calendar_activities#destroy", :id => "1")
    end

  end
end
