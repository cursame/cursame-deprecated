require 'spec_helper'

describe "chats/show.html.erb" do
  before(:each) do
    @chat = assign(:chat, stub_model(Chat,
      :user => "User",
      :text => "Text"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/User/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Text/)
  end
end
