require 'spec_helper'

describe "NotificacionesAdminActualice" do
  describe "GET /notificaciones_admin_actualice" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get notificaciones_admin_actualice_path
      response.status.should be(200)
    end
  end
end
