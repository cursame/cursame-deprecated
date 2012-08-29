# Extensive Docs at http://github.com/innku/innsights-gem

Innsights.setup do
  config :test do
    enable false
  end

  # Guardar cambios en red
  # controllers/supervisor/network_controller.rb:15
  # "Red Actualizada"
  #
  # Cambiar rol a usuario (No hay una acción específica para cambiar
  # rol a usuario)
  # "Perfil actualizado por supervisor"
  # controllers/supervisor/users_controller.rb:33
  #
  # Importar maestros
  # Importar estudiantes
  #  Es la misma acción para importar maestros y Usuarios
  #  app/controllers/assets_controller.rb:17
  #
  # Exportar maestros
  # Exportar estudiantes
  #  Es la misma acción para exportar maestros y Usuarios
  #  app/controllers/assets_controller.rb:17
  #
  # Crear usuario
  # Crear profesor
  # Crear estudiante
  # Crear administrador
  watch User do
    report lambda { |user| "#{I18n.t user.role, :scope => 'supervisor.shared.teachers'} creado" }

    user do |user|
      user
    end

    group do |user|
      user.networks.last
    end

    upon :create
  end

  # Autorizar maestros
  # Rechazar maestro
  # controllers/statuses_controller.rb:24-28
 
  # Cambiar contraseña
  # controllers/settings_controller.rb:20
   
  # Cambiar de preferencias de notification
  # controllers/settings_controller.rb:20
end
