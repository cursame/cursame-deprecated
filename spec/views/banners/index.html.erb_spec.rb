require 'spec_helper'

describe "banners/index" do
  before(:each) do
    assign(:banners, [
      stub_model(Banner,
        :title => "Title",
        :description => "MyText",
        :date_promotion => "Date Promotion",
        :link => "Link"
      ),
      stub_model(Banner,
        :title => "Title",
        :description => "MyText",
        :date_promotion => "Date Promotion",
        :link => "Link"
      )
    ])
  end

  it "renders a list of banners" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Date Promotion".to_s, :count => 2
    assert_select "tr>td", :text => "Link".to_s, :count => 2
  end
end
