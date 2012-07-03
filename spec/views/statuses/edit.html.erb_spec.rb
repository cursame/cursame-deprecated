require 'spec_helper'

describe "statuses/edit" do
  before(:each) do
    @status = assign(:status, stub_model(Status,
      :view_status => "MyString"
    ))
  end

  it "renders the edit status form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => statuses_path(@status), :method => "post" do
      assert_select "input#status_view_status", :name => "status[view_status]"
    end
  end
end
