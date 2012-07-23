require 'spec_helper'

describe "tutoriales/edit" do
  before(:each) do
    @tutoriale = assign(:tutoriale, stub_model(Tutoriale,
      :title => "MyString",
      :description => "MyText",
      :link => "MyString"
    ))
  end

  it "renders the edit tutoriale form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tutoriales_path(@tutoriale), :method => "post" do
      assert_select "input#tutoriale_title", :name => "tutoriale[title]"
      assert_select "textarea#tutoriale_description", :name => "tutoriale[description]"
      assert_select "input#tutoriale_link", :name => "tutoriale[link]"
    end
  end
end
