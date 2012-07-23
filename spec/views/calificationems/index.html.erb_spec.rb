require 'spec_helper'

describe "calificationems/index" do
  before(:each) do
    assign(:calificationems, [
      stub_model(Calificationem,
        :raiting => 1,
        :anotation_coment => "MyText"
      ),
      stub_model(Calificationem,
        :raiting => 1,
        :anotation_coment => "MyText"
      )
    ])
  end

  it "renders a list of calificationems" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
