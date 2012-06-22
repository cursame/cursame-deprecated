require 'spec_helper'

describe "send_reports/edit" do
  before(:each) do
    @send_report = assign(:send_report, stub_model(SendReport,
      :title => "MyString",
      :text => "MyText"
    ))
  end

  it "renders the edit send_report form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => send_reports_path(@send_report), :method => "post" do
      assert_select "input#send_report_title", :name => "send_report[title]"
      assert_select "textarea#send_report_text", :name => "send_report[text]"
    end
  end
end
