require 'spec_helper'

describe "send_reports/index" do
  before(:each) do
    assign(:send_reports, [
      stub_model(SendReport,
        :title => "Title",
        :text => "MyText"
      ),
      stub_model(SendReport,
        :title => "Title",
        :text => "MyText"
      )
    ])
  end

  it "renders a list of send_reports" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
