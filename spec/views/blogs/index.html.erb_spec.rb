require 'spec_helper'

describe "blogs/index" do
  before(:each) do
    assign(:blogs, [
      stub_model(Blog,
        :post => "Post",
        :content => "MyText",
        :menu_category => "Menu Category"
      ),
      stub_model(Blog,
        :post => "Post",
        :content => "MyText",
        :menu_category => "Menu Category"
      )
    ])
  end

  it "renders a list of blogs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Post".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Menu Category".to_s, :count => 2
  end
end
