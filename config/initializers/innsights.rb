# encoding: utf-8
# Extensive Docs at http://github.com/innku/innsights-gem

Innsights.setup do
  config :test do
    enable false
    debugging true
  end

  # ======= Admin
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
  # Crear usuario # Crear profesor
  # Crear estudiante
  # Crear administrador
  watch User do
    report lambda { |user| "Registro de #{I18n.t user.role, :scope => 'supervisor.shared.teachers'}" }

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

  # ======== Maestros
  # crear curso 
  watch Course do
    report "Curso creado"
    
    user do |course|
      course.teachers.first
    end

    group :network
    upon :create
  end

  # editar curso 
  # app/controllers/courses_controller.rb:76

  # solicitar entrar a un curso como maestro 
  watch Enrollment do   
    report lambda { |e|
      "#{I18n.t e.role, :scope => 'supervisor.shared.teachers'} solicita entrar en curso"
    }
    user :user

    group do |enrollment|
      enrollment.course.network
    end

    upon :create
  end

  # aceptar miembro a un curso 
  # quitar miembro de un curso
  watch Enrollment do
    report lambda { |e|
      case e.state
      when 'pending'
        "#{I18n.t e.role, :scope => 'supervisor.shared.teachers'} solicita entrar en curso"
      when 'accepted'
        "#{I18n.t e.role, :scope => 'supervisor.shared.teachers'} aceptado en curso"
      when 'rejected'
        "#{I18n.t e.role, :scope => 'supervisor.shared.teachers'} rechazado en curso"
      end
    }
    user :user

    group do |enrollment|
      enrollment.course.network
    end

    timestamp :updated_at
    upon :update
  end

  # comentar en un curso 
  # comentar en cuestionario 
  # dejar comentario en muro en una tarea 
  # comentar en discusión 
  watch Comment do
    report lambda { |comment|
      case comment.commentable_type
      when "User" 
        "Comentario sobre usuario"
      when "Course"
        "Comentario sobre curso"
      when "Discussion"
        "Comentario en discusión"
      when "Comment"
        "Commentario respondido"
      when "Delivery"
        "Comentario sobre entrega"
      when "Assignment"
        "Comentario sobre tarea"
      end
    }

    user :user

    group do |comment|
      commentable = comment.commentable
      case comment.commentable_type
      when "User" 
        (commentable.networks & comment.user.networks).first        
      when "Course"
        commentable.network
      when "Discussion"
        commentable.course.network
      when "Comment"
        (commentable.user.networks & comment.user.networks).first        
      when "Delivery"
        commentable.assignment.course.network
      when "Assignment"
        commentable.course.network
      end
    end

    upon :create
  end

  # crear tarea 
  # app/controllers/assignments_controller.rb:23
  
  # editar tarea 
  # app/controllers/assignments_controller.rb:39
  
  # eliminar tarea 
  # app/controllers/assignments_controller.rb:55
  
  # crear cuestionario 
  # app/controllers/surveys_controller.rb:22
  #
  # editar cuestionario 
  # app/controllers/surveys_controller.rb:51
  #
  # eliminar cuestionario 
  # app/controllers/surveys_controller.rb:62
  #
  # crear discusión 
  # app/controllers/discussions_controller.rb:19
  #
  # editar discusión 
  # app/controllers/discussions_controller.rb:52
  #
  # eliminar discusión 
  # app/controllers/discussions_controller.rb:40
  #
  # ================== Alumno 
  # solicitar unirse a un curso (arriba)
  # comentar en un muro de un perfil (arriba)
  #
  # entregar una tarea 
  watch Delivery do
    report "Tarea entregada"

    group do |delivery|
      delivery.assignment.course.network
    end

    user :user
    upon :create
  end

  # contestar un cuestionario 
  watch SurveyReply do
    report "Respuesta a cuestionario entregada"

    group do |survey|
      survey.course.network

    end

    user :user
    upon :create
  end
  
  # editar una entrega 
  watch Delivery do
    report "Tarea editada"

    group do |delivery|
      delivery.assignment.course.network
    end

    user :user
    upon :update
    timestamp :updated_at
  end

  # editar una respuesta de cuestionario 
  watch SurveyReply do
    report "Respuesta a cuestionario editada"

    group do |survey|
      survey.course.network
    end

    user :user
    upon :update
    timestamp :updated_at
  end
end
