require 'spec_helper'

describe "AcceptedTerms" do
  describe "GET /accepted_terms" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get accepted_terms_path
      response.status.should be(200)
    end
  end
end
