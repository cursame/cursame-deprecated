require 'spec_helper'

describe "bug_answers/show" do
  before(:each) do
    @bug_answer = assign(:bug_answer, stub_model(BugAnswer,
      :container => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
