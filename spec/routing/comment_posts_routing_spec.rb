require "spec_helper"

describe CommentPostsController do
  describe "routing" do

    it "routes to #index" do
      get("/comment_posts").should route_to("comment_posts#index")
    end

    it "routes to #new" do
      get("/comment_posts/new").should route_to("comment_posts#new")
    end

    it "routes to #show" do
      get("/comment_posts/1").should route_to("comment_posts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/comment_posts/1/edit").should route_to("comment_posts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/comment_posts").should route_to("comment_posts#create")
    end

    it "routes to #update" do
      put("/comment_posts/1").should route_to("comment_posts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/comment_posts/1").should route_to("comment_posts#destroy", :id => "1")
    end

  end
end
