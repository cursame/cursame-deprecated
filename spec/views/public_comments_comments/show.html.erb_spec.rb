require 'spec_helper'

describe "public_comments_comments/show" do
  before(:each) do
    @public_comments_comment = assign(:public_comments_comment, stub_model(PublicCommentsComment,
      :user_id => 1,
      :network_id => 2,
      :text => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/MyText/)
  end
end
