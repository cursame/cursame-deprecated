require "spec_helper"

describe NotificacionesAdminActualiceController do
  describe "routing" do

    it "routes to #index" do
      get("/notificaciones_admin_actualice").should route_to("notificaciones_admin_actualice#index")
    end

    it "routes to #new" do
      get("/notificaciones_admin_actualice/new").should route_to("notificaciones_admin_actualice#new")
    end

    it "routes to #show" do
      get("/notificaciones_admin_actualice/1").should route_to("notificaciones_admin_actualice#show", :id => "1")
    end

    it "routes to #edit" do
      get("/notificaciones_admin_actualice/1/edit").should route_to("notificaciones_admin_actualice#edit", :id => "1")
    end

    it "routes to #create" do
      post("/notificaciones_admin_actualice").should route_to("notificaciones_admin_actualice#create")
    end

    it "routes to #update" do
      put("/notificaciones_admin_actualice/1").should route_to("notificaciones_admin_actualice#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/notificaciones_admin_actualice/1").should route_to("notificaciones_admin_actualice#destroy", :id => "1")
    end

  end
end
