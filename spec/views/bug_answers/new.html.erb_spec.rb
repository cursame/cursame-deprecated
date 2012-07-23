require 'spec_helper'

describe "bug_answers/new" do
  before(:each) do
    assign(:bug_answer, stub_model(BugAnswer,
      :container => "MyText"
    ).as_new_record)
  end

  it "renders new bug_answer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => bug_answers_path, :method => "post" do
      assert_select "textarea#bug_answer_container", :name => "bug_answer[container]"
    end
  end
end
