require "spec_helper"

describe AcceptedTermsController do
  describe "routing" do

    it "routes to #index" do
      get("/accepted_terms").should route_to("accepted_terms#index")
    end

    it "routes to #new" do
      get("/accepted_terms/new").should route_to("accepted_terms#new")
    end

    it "routes to #show" do
      get("/accepted_terms/1").should route_to("accepted_terms#show", :id => "1")
    end

    it "routes to #edit" do
      get("/accepted_terms/1/edit").should route_to("accepted_terms#edit", :id => "1")
    end

    it "routes to #create" do
      post("/accepted_terms").should route_to("accepted_terms#create")
    end

    it "routes to #update" do
      put("/accepted_terms/1").should route_to("accepted_terms#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/accepted_terms/1").should route_to("accepted_terms#destroy", :id => "1")
    end

  end
end
