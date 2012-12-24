require 'spec_helper'

describe AnalyticsController do

  describe "GET 'visitas'" do
    it "returns http success" do
      get 'visitas'
      response.should be_success
    end
  end

end
