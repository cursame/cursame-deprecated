require 'spec_helper'

describe "comment_posts/index" do
  before(:each) do
    assign(:comment_posts, [
      stub_model(CommentPost,
        :title => "Title",
        :content => "MyText"
      ),
      stub_model(CommentPost,
        :title => "Title",
        :content => "MyText"
      )
    ])
  end

  it "renders a list of comment_posts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
