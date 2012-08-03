require 'spec_helper'

describe "public_comments_comments/edit" do
  before(:each) do
    @public_comments_comment = assign(:public_comments_comment, stub_model(PublicCommentsComment,
      :user_id => 1,
      :network_id => 1,
      :text => "MyText"
    ))
  end

  it "renders the edit public_comments_comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => public_comments_comments_path(@public_comments_comment), :method => "post" do
      assert_select "input#public_comments_comment_user_id", :name => "public_comments_comment[user_id]"
      assert_select "input#public_comments_comment_network_id", :name => "public_comments_comment[network_id]"
      assert_select "textarea#public_comments_comment_text", :name => "public_comments_comment[text]"
    end
  end
end
