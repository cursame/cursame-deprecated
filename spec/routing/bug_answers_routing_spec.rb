require "spec_helper"

describe BugAnswersController do
  describe "routing" do

    it "routes to #index" do
      get("/bug_answers").should route_to("bug_answers#index")
    end

    it "routes to #new" do
      get("/bug_answers/new").should route_to("bug_answers#new")
    end

    it "routes to #show" do
      get("/bug_answers/1").should route_to("bug_answers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/bug_answers/1/edit").should route_to("bug_answers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/bug_answers").should route_to("bug_answers#create")
    end

    it "routes to #update" do
      put("/bug_answers/1").should route_to("bug_answers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/bug_answers/1").should route_to("bug_answers#destroy", :id => "1")
    end

  end
end
