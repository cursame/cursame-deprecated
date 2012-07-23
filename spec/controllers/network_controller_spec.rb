require 'spec_helper'

describe NetworkController do

  describe "GET 'network_cc'" do
    it "returns http success" do
      get 'network_cc'
      response.should be_success
    end
  end

end
