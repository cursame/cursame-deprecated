require 'spec_helper'

describe "blogs/new" do
  before(:each) do
    assign(:blog, stub_model(Blog,
      :post => "MyString",
      :content => "MyText",
      :menu_category => "MyString"
    ).as_new_record)
  end

  it "renders new blog form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => blogs_path, :method => "post" do
      assert_select "input#blog_post", :name => "blog[post]"
      assert_select "textarea#blog_content", :name => "blog[content]"
      assert_select "input#blog_menu_category", :name => "blog[menu_category]"
    end
  end
end
