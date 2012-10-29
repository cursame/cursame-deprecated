require 'spec_helper'

describe "accepted_terms/edit" do
  before(:each) do
    @accepted_term = assign(:accepted_term, stub_model(AcceptedTerm,
      :user => "MyString",
      :acepted => "MyString"
    ))
  end

  it "renders the edit accepted_term form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => accepted_terms_path(@accepted_term), :method => "post" do
      assert_select "input#accepted_term_user", :name => "accepted_term[user]"
      assert_select "input#accepted_term_acepted", :name => "accepted_term[acepted]"
    end
  end
end
