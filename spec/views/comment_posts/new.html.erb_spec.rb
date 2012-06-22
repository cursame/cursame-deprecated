require 'spec_helper'

describe "comment_posts/new" do
  before(:each) do
    assign(:comment_post, stub_model(CommentPost,
      :title => "MyString",
      :content => "MyText"
    ).as_new_record)
  end

  it "renders new comment_post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => comment_posts_path, :method => "post" do
      assert_select "input#comment_post_title", :name => "comment_post[title]"
      assert_select "textarea#comment_post_content", :name => "comment_post[content]"
    end
  end
end
