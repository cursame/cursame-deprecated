require 'spec_helper'

describe "like_not_likes/show" do
  before(:each) do
    @like_not_like = assign(:like_not_like, stub_model(LikeNotLike,
      :like => 1,
      :user_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
