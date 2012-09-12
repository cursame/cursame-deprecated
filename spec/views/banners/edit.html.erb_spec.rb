require 'spec_helper'

describe "banners/edit" do
  before(:each) do
    @banner = assign(:banner, stub_model(Banner,
      :title => "MyString",
      :description => "MyText",
      :date_promotion => "MyString",
      :link => "MyString"
    ))
  end

  it "renders the edit banner form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => banners_path(@banner), :method => "post" do
      assert_select "input#banner_title", :name => "banner[title]"
      assert_select "textarea#banner_description", :name => "banner[description]"
      assert_select "input#banner_date_promotion", :name => "banner[date_promotion]"
      assert_select "input#banner_link", :name => "banner[link]"
    end
  end
end
