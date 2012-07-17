require 'spec_helper'

describe "favorites/edit" do
  before(:each) do
    @favorite = assign(:favorite, stub_model(Favorite,
      :user_id => 1,
      :user_favorite_id => 1
    ))
  end

  it "renders the edit favorite form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => favorites_path(@favorite), :method => "post" do
      assert_select "input#favorite_user_id", :name => "favorite[user_id]"
      assert_select "input#favorite_user_favorite_id", :name => "favorite[user_favorite_id]"
    end
  end
end
