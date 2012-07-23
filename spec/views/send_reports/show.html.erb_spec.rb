require 'spec_helper'

describe "send_reports/show" do
  before(:each) do
    @send_report = assign(:send_report, stub_model(SendReport,
      :title => "Title",
      :text => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
  end
end
