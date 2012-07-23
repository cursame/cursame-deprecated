require 'spec_helper'

describe "calificationems/show" do
  before(:each) do
    @calificationem = assign(:calificationem, stub_model(Calificationem,
      :raiting => 1,
      :anotation_coment => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/MyText/)
  end
end
