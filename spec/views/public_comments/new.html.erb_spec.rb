require 'spec_helper'

describe "public_comments/new" do
  before(:each) do
    assign(:public_comment, stub_model(PublicComment,
      :commentable_public_id => 1,
      :commentable_public_type => "MyString",
      :user_id => 1
    ).as_new_record)
  end

  it "renders new public_comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => public_comments_path, :method => "post" do
      assert_select "input#public_comment_commentable_public_id", :name => "public_comment[commentable_public_id]"
      assert_select "input#public_comment_commentable_public_type", :name => "public_comment[commentable_public_type]"
      assert_select "input#public_comment_user_id", :name => "public_comment[user_id]"
    end
  end
end
