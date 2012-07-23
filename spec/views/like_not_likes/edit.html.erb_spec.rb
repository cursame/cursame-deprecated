require 'spec_helper'

describe "like_not_likes/edit" do
  before(:each) do
    @like_not_like = assign(:like_not_like, stub_model(LikeNotLike,
      :like => 1,
      :user_id => 1
    ))
  end

  it "renders the edit like_not_like form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => like_not_likes_path(@like_not_like), :method => "post" do
      assert_select "input#like_not_like_like", :name => "like_not_like[like]"
      assert_select "input#like_not_like_user_id", :name => "like_not_like[user_id]"
    end
  end
end
