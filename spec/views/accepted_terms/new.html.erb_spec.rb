require 'spec_helper'

describe "accepted_terms/new" do
  before(:each) do
    assign(:accepted_term, stub_model(AcceptedTerm,
      :user => "MyString",
      :acepted => "MyString"
    ).as_new_record)
  end

  it "renders new accepted_term form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => accepted_terms_path, :method => "post" do
      assert_select "input#accepted_term_user", :name => "accepted_term[user]"
      assert_select "input#accepted_term_acepted", :name => "accepted_term[acepted]"
    end
  end
end
