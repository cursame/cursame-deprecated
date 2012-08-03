require 'spec_helper'

describe "public_comments/show" do
  before(:each) do
    @public_comment = assign(:public_comment, stub_model(PublicComment,
      :commentable_public_id => 1,
      :commentable_public_type => "Commentable Public Type",
      :user_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Commentable Public Type/)
    rendered.should match(/2/)
  end
end
