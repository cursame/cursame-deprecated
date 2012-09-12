require 'spec_helper'

describe "banners/new" do
  before(:each) do
    assign(:banner, stub_model(Banner,
      :title => "MyString",
      :description => "MyText",
      :date_promotion => "MyString",
      :link => "MyString"
    ).as_new_record)
  end

  it "renders new banner form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => banners_path, :method => "post" do
      assert_select "input#banner_title", :name => "banner[title]"
      assert_select "textarea#banner_description", :name => "banner[description]"
      assert_select "input#banner_date_promotion", :name => "banner[date_promotion]"
      assert_select "input#banner_link", :name => "banner[link]"
    end
  end
end
