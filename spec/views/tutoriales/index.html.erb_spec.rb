require 'spec_helper'

describe "tutoriales/index" do
  before(:each) do
    assign(:tutoriales, [
      stub_model(Tutoriale,
        :title => "Title",
        :description => "MyText",
        :link => "Link"
      ),
      stub_model(Tutoriale,
        :title => "Title",
        :description => "MyText",
        :link => "Link"
      )
    ])
  end

  it "renders a list of tutoriales" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Link".to_s, :count => 2
  end
end
