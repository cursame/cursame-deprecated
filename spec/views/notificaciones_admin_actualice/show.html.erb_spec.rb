require 'spec_helper'

describe "notificaciones_admin_actualice/show" do
  before(:each) do
    @notificaciones_admin_actualouse = assign(:notificaciones_admin_actualouse, stub_model(NotificacionesAdminActualouse,
      :title => "Title",
      :content => "Content",
      :link_video => "Link Video"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Content/)
    rendered.should match(/Link Video/)
  end
end
