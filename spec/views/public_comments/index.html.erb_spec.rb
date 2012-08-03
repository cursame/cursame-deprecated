require 'spec_helper'

describe "public_comments/index" do
  before(:each) do
    assign(:public_comments, [
      stub_model(PublicComment,
        :commentable_public_id => 1,
        :commentable_public_type => "Commentable Public Type",
        :user_id => 2
      ),
      stub_model(PublicComment,
        :commentable_public_id => 1,
        :commentable_public_type => "Commentable Public Type",
        :user_id => 2
      )
    ])
  end

  it "renders a list of public_comments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Commentable Public Type".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
