require "spec_helper"

describe LikeNotLikesController do
  describe "routing" do

    it "routes to #index" do
      get("/like_not_likes").should route_to("like_not_likes#index")
    end

    it "routes to #new" do
      get("/like_not_likes/new").should route_to("like_not_likes#new")
    end

    it "routes to #show" do
      get("/like_not_likes/1").should route_to("like_not_likes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/like_not_likes/1/edit").should route_to("like_not_likes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/like_not_likes").should route_to("like_not_likes#create")
    end

    it "routes to #update" do
      put("/like_not_likes/1").should route_to("like_not_likes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/like_not_likes/1").should route_to("like_not_likes#destroy", :id => "1")
    end

  end
end
