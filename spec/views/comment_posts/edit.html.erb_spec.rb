require 'spec_helper'

describe "comment_posts/edit" do
  before(:each) do
    @comment_post = assign(:comment_post, stub_model(CommentPost,
      :title => "MyString",
      :content => "MyText"
    ))
  end

  it "renders the edit comment_post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => comment_posts_path(@comment_post), :method => "post" do
      assert_select "input#comment_post_title", :name => "comment_post[title]"
      assert_select "textarea#comment_post_content", :name => "comment_post[content]"
    end
  end
end
