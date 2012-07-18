require 'spec_helper'

describe "tutoriales/show" do
  before(:each) do
    @tutoriale = assign(:tutoriale, stub_model(Tutoriale,
      :title => "Title",
      :description => "MyText",
      :link => "Link"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/Link/)
  end
end
