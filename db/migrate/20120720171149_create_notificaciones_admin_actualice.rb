class CreateNotificacionesAdminActualice < ActiveRecord::Migration
  def change
    create_table :notificaciones_admin_actualice do |t|
      t.string :title, :default => "¡¡Ahora notificaciones del administrador!!"
      t.string :content, :default => "Ahora puedes recibir notificaciones del administrador para estar siempre enterado de las últicas actualizaciones de Cúrsame"
      t.string :link_video, :default => "link"

      t.timestamps
    end
  end
end
