require 'spec_helper'

describe "comment_posts/show" do
  before(:each) do
    @comment_post = assign(:comment_post, stub_model(CommentPost,
      :title => "Title",
      :content => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
  end
end
