require 'spec_helper'

describe "accepted_terms/show" do
  before(:each) do
    @accepted_term = assign(:accepted_term, stub_model(AcceptedTerm,
      :user => "User",
      :acepted => "Acepted"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/User/)
    rendered.should match(/Acepted/)
  end
end
