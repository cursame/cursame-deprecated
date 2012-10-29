require 'spec_helper'

describe "accepted_terms/index" do
  before(:each) do
    assign(:accepted_terms, [
      stub_model(AcceptedTerm,
        :user => "User",
        :acepted => "Acepted"
      ),
      stub_model(AcceptedTerm,
        :user => "User",
        :acepted => "Acepted"
      )
    ])
  end

  it "renders a list of accepted_terms" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "User".to_s, :count => 2
    assert_select "tr>td", :text => "Acepted".to_s, :count => 2
  end
end
