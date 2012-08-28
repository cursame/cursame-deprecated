require 'spec_helper'

describe "new_users_change_types/show" do
  before(:each) do
    @new_users_change_type = assign(:new_users_change_type, stub_model(NewUsersChangeType,
      :new_old => 1,
      :user_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
