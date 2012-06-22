require 'spec_helper'

describe "like_not_likes/new" do
  before(:each) do
    assign(:like_not_like, stub_model(LikeNotLike,
      :like => 1,
      :user_id => 1
    ).as_new_record)
  end

  it "renders new like_not_like form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => like_not_likes_path, :method => "post" do
      assert_select "input#like_not_like_like", :name => "like_not_like[like]"
      assert_select "input#like_not_like_user_id", :name => "like_not_like[user_id]"
    end
  end
end
