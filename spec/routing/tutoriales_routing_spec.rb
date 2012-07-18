require "spec_helper"

describe TutorialesController do
  describe "routing" do

    it "routes to #index" do
      get("/tutoriales").should route_to("tutoriales#index")
    end

    it "routes to #new" do
      get("/tutoriales/new").should route_to("tutoriales#new")
    end

    it "routes to #show" do
      get("/tutoriales/1").should route_to("tutoriales#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tutoriales/1/edit").should route_to("tutoriales#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tutoriales").should route_to("tutoriales#create")
    end

    it "routes to #update" do
      put("/tutoriales/1").should route_to("tutoriales#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tutoriales/1").should route_to("tutoriales#destroy", :id => "1")
    end

  end
end
