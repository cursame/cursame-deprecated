require 'spec_helper'

describe "chats/edit.html.erb" do
  before(:each) do
    @chat = assign(:chat, stub_model(Chat,
      :user => "MyString",
      :text => "MyString"
    ))
  end

  it "renders the edit chat form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => chats_path(@chat), :method => "post" do
      assert_select "input#chat_user", :name => "chat[user]"
      assert_select "input#chat_text", :name => "chat[text]"
    end
  end
end
