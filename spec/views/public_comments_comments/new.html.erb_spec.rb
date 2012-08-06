require 'spec_helper'

describe "public_comments_comments/new" do
  before(:each) do
    assign(:public_comments_comment, stub_model(PublicCommentsComment,
      :user_id => 1,
      :network_id => 1,
      :text => "MyText"
    ).as_new_record)
  end

  it "renders new public_comments_comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => public_comments_comments_path, :method => "post" do
      assert_select "input#public_comments_comment_user_id", :name => "public_comments_comment[user_id]"
      assert_select "input#public_comments_comment_network_id", :name => "public_comments_comment[network_id]"
      assert_select "textarea#public_comments_comment_text", :name => "public_comments_comment[text]"
    end
  end
end
