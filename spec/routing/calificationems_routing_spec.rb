require "spec_helper"

describe CalificationemsController do
  describe "routing" do

    it "routes to #index" do
      get("/calificationems").should route_to("calificationems#index")
    end

    it "routes to #new" do
      get("/calificationems/new").should route_to("calificationems#new")
    end

    it "routes to #show" do
      get("/calificationems/1").should route_to("calificationems#show", :id => "1")
    end

    it "routes to #edit" do
      get("/calificationems/1/edit").should route_to("calificationems#edit", :id => "1")
    end

    it "routes to #create" do
      post("/calificationems").should route_to("calificationems#create")
    end

    it "routes to #update" do
      put("/calificationems/1").should route_to("calificationems#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/calificationems/1").should route_to("calificationems#destroy", :id => "1")
    end

  end
end
