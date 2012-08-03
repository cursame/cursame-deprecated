require 'spec_helper'

describe "public_comments_comments/index" do
  before(:each) do
    assign(:public_comments_comments, [
      stub_model(PublicCommentsComment,
        :user_id => 1,
        :network_id => 2,
        :text => "MyText"
      ),
      stub_model(PublicCommentsComment,
        :user_id => 1,
        :network_id => 2,
        :text => "MyText"
      )
    ])
  end

  it "renders a list of public_comments_comments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
