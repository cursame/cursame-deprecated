require 'spec_helper'

describe "chats/index.html.erb" do
  before(:each) do
    assign(:chats, [
      stub_model(Chat,
        :user => "User",
        :text => "Text"
      ),
      stub_model(Chat,
        :user => "User",
        :text => "Text"
      )
    ])
  end

  it "renders a list of chats" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "User".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Text".to_s, :count => 2
  end
end
