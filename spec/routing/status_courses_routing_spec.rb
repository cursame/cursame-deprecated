require "spec_helper"

describe StatusCoursesController do
  describe "routing" do

    it "routes to #index" do
      get("/status_courses").should route_to("status_courses#index")
    end

    it "routes to #new" do
      get("/status_courses/new").should route_to("status_courses#new")
    end

    it "routes to #show" do
      get("/status_courses/1").should route_to("status_courses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/status_courses/1/edit").should route_to("status_courses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/status_courses").should route_to("status_courses#create")
    end

    it "routes to #update" do
      put("/status_courses/1").should route_to("status_courses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/status_courses/1").should route_to("status_courses#destroy", :id => "1")
    end

  end
end
