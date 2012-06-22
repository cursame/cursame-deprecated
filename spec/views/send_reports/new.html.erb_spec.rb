require 'spec_helper'

describe "send_reports/new" do
  before(:each) do
    assign(:send_report, stub_model(SendReport,
      :title => "MyString",
      :text => "MyText"
    ).as_new_record)
  end

  it "renders new send_report form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => send_reports_path, :method => "post" do
      assert_select "input#send_report_title", :name => "send_report[title]"
      assert_select "textarea#send_report_text", :name => "send_report[text]"
    end
  end
end
