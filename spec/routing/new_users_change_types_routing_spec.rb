require "spec_helper"

describe NewUsersChangeTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/new_users_change_types").should route_to("new_users_change_types#index")
    end

    it "routes to #new" do
      get("/new_users_change_types/new").should route_to("new_users_change_types#new")
    end

    it "routes to #show" do
      get("/new_users_change_types/1").should route_to("new_users_change_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/new_users_change_types/1/edit").should route_to("new_users_change_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/new_users_change_types").should route_to("new_users_change_types#create")
    end

    it "routes to #update" do
      put("/new_users_change_types/1").should route_to("new_users_change_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/new_users_change_types/1").should route_to("new_users_change_types#destroy", :id => "1")
    end

  end
end
