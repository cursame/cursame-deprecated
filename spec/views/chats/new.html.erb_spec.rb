require 'spec_helper'

describe "chats/new.html.erb" do
  before(:each) do
    assign(:chat, stub_model(Chat,
      :user => "MyString",
      :text => "MyString"
    ).as_new_record)
  end

  it "renders new chat form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => chats_path, :method => "post" do
      assert_select "input#chat_user", :name => "chat[user]"
      assert_select "input#chat_text", :name => "chat[text]"
    end
  end
end
