require 'spec_helper'

describe "bug_answers/index" do
  before(:each) do
    assign(:bug_answers, [
      stub_model(BugAnswer,
        :container => "MyText"
      ),
      stub_model(BugAnswer,
        :container => "MyText"
      )
    ])
  end

  it "renders a list of bug_answers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
