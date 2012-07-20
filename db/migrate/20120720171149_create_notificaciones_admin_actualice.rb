class CreateNotificacionesAdminActualice < ActiveRecord::Migration
  def change
    create_table :notificaciones_admin_actualice do |t|
      t.string :title
      t.string :content
      t.string :link_video

      t.timestamps
    end
  end
end
