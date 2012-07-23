require 'spec_helper'

describe "calificationems/new" do
  before(:each) do
    assign(:calificationem, stub_model(Calificationem,
      :raiting => 1,
      :anotation_coment => "MyText"
    ).as_new_record)
  end

  it "renders new calificationem form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => calificationems_path, :method => "post" do
      assert_select "input#calificationem_raiting", :name => "calificationem[raiting]"
      assert_select "textarea#calificationem_anotation_coment", :name => "calificationem[anotation_coment]"
    end
  end
end
