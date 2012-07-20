require 'spec_helper'

describe "notificaciones_admin_actualice/new" do
  before(:each) do
    assign(:notificaciones_admin_actualouse, stub_model(NotificacionesAdminActualouse,
      :title => "MyString",
      :content => "MyString",
      :link_video => "MyString"
    ).as_new_record)
  end

  it "renders new notificaciones_admin_actualouse form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => notificaciones_admin_actualice_path, :method => "post" do
      assert_select "input#notificaciones_admin_actualouse_title", :name => "notificaciones_admin_actualouse[title]"
      assert_select "input#notificaciones_admin_actualouse_content", :name => "notificaciones_admin_actualouse[content]"
      assert_select "input#notificaciones_admin_actualouse_link_video", :name => "notificaciones_admin_actualouse[link_video]"
    end
  end
end
