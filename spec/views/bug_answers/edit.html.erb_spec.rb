require 'spec_helper'

describe "bug_answers/edit" do
  before(:each) do
    @bug_answer = assign(:bug_answer, stub_model(BugAnswer,
      :container => "MyText"
    ))
  end

  it "renders the edit bug_answer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => bug_answers_path(@bug_answer), :method => "post" do
      assert_select "textarea#bug_answer_container", :name => "bug_answer[container]"
    end
  end
end
