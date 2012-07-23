require 'spec_helper'

describe "calificationems/edit" do
  before(:each) do
    @calificationem = assign(:calificationem, stub_model(Calificationem,
      :raiting => 1,
      :anotation_coment => "MyText"
    ))
  end

  it "renders the edit calificationem form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => calificationems_path(@calificationem), :method => "post" do
      assert_select "input#calificationem_raiting", :name => "calificationem[raiting]"
      assert_select "textarea#calificationem_anotation_coment", :name => "calificationem[anotation_coment]"
    end
  end
end
