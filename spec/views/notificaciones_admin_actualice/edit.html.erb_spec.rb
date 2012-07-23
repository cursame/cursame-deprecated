require 'spec_helper'

describe "notificaciones_admin_actualice/edit" do
  before(:each) do
    @notificaciones_admin_actualouse = assign(:notificaciones_admin_actualouse, stub_model(NotificacionesAdminActualouse,
      :title => "MyString",
      :content => "MyString",
      :link_video => "MyString"
    ))
  end

  it "renders the edit notificaciones_admin_actualouse form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => notificaciones_admin_actualice_path(@notificaciones_admin_actualouse), :method => "post" do
      assert_select "input#notificaciones_admin_actualouse_title", :name => "notificaciones_admin_actualouse[title]"
      assert_select "input#notificaciones_admin_actualouse_content", :name => "notificaciones_admin_actualouse[content]"
      assert_select "input#notificaciones_admin_actualouse_link_video", :name => "notificaciones_admin_actualouse[link_video]"
    end
  end
end
