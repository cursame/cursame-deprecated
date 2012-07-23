require "spec_helper"

describe StutusCoursesController do
  describe "routing" do

    it "routes to #index" do
      get("/stutus_courses").should route_to("stutus_courses#index")
    end

    it "routes to #new" do
      get("/stutus_courses/new").should route_to("stutus_courses#new")
    end

    it "routes to #show" do
      get("/stutus_courses/1").should route_to("stutus_courses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/stutus_courses/1/edit").should route_to("stutus_courses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/stutus_courses").should route_to("stutus_courses#create")
    end

    it "routes to #update" do
      put("/stutus_courses/1").should route_to("stutus_courses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/stutus_courses/1").should route_to("stutus_courses#destroy", :id => "1")
    end

  end
end
