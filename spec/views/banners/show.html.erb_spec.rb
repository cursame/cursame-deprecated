require 'spec_helper'

describe "banners/show" do
  before(:each) do
    @banner = assign(:banner, stub_model(Banner,
      :title => "Title",
      :description => "MyText",
      :date_promotion => "Date Promotion",
      :link => "Link"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/Date Promotion/)
    rendered.should match(/Link/)
  end
end
