require 'spec_helper'

describe "notificaciones_admin_actualice/index" do
  before(:each) do
    assign(:notificaciones_admin_actualice, [
      stub_model(NotificacionesAdminActualouse,
        :title => "Title",
        :content => "Content",
        :link_video => "Link Video"
      ),
      stub_model(NotificacionesAdminActualouse,
        :title => "Title",
        :content => "Content",
        :link_video => "Link Video"
      )
    ])
  end

  it "renders a list of notificaciones_admin_actualice" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    assert_select "tr>td", :text => "Link Video".to_s, :count => 2
  end
end
