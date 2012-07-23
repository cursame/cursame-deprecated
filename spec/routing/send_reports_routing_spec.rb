require "spec_helper"

describe SendReportsController do
  describe "routing" do

    it "routes to #index" do
      get("/send_reports").should route_to("send_reports#index")
    end

    it "routes to #new" do
      get("/send_reports/new").should route_to("send_reports#new")
    end

    it "routes to #show" do
      get("/send_reports/1").should route_to("send_reports#show", :id => "1")
    end

    it "routes to #edit" do
      get("/send_reports/1/edit").should route_to("send_reports#edit", :id => "1")
    end

    it "routes to #create" do
      post("/send_reports").should route_to("send_reports#create")
    end

    it "routes to #update" do
      put("/send_reports/1").should route_to("send_reports#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/send_reports/1").should route_to("send_reports#destroy", :id => "1")
    end

  end
end
