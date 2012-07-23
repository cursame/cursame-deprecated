require 'spec_helper'

describe "blogs/show" do
  before(:each) do
    @blog = assign(:blog, stub_model(Blog,
      :post => "Post",
      :content => "MyText",
      :menu_category => "Menu Category"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Post/)
    rendered.should match(/MyText/)
    rendered.should match(/Menu Category/)
  end
end
