require 'spec_helper'

describe NetworksController do

  describe "GET 'network_cc'" do
    it "returns http success" do
      get 'network_cc'
      response.should be_success
    end
  end

end
