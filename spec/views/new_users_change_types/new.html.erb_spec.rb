require 'spec_helper'

describe "new_users_change_types/new" do
  before(:each) do
    assign(:new_users_change_type, stub_model(NewUsersChangeType,
      :new_old => 1,
      :user_id => 1
    ).as_new_record)
  end

  it "renders new new_users_change_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => new_users_change_types_path, :method => "post" do
      assert_select "input#new_users_change_type_new_old", :name => "new_users_change_type[new_old]"
      assert_select "input#new_users_change_type_user_id", :name => "new_users_change_type[user_id]"
    end
  end
end
