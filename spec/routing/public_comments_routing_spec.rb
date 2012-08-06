require "spec_helper"

describe PublicCommentsController do
  describe "routing" do

    it "routes to #index" do
      get("/public_comments").should route_to("public_comments#index")
    end

    it "routes to #new" do
      get("/public_comments/new").should route_to("public_comments#new")
    end

    it "routes to #show" do
      get("/public_comments/1").should route_to("public_comments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/public_comments/1/edit").should route_to("public_comments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/public_comments").should route_to("public_comments#create")
    end

    it "routes to #update" do
      put("/public_comments/1").should route_to("public_comments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/public_comments/1").should route_to("public_comments#destroy", :id => "1")
    end

  end
end
