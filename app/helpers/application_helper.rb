module ApplicationHelper

  def avatar(user, size=nil)
    case size
      when :small
        # FIXME: We need a fallback image for supervisors.
        fallback = user.teacher? ? 'profesor.png' : 'alumno.png'
        image_tag(user.avatar_file.blank? ? fallback : user.avatar_file.small.url)
      when :xsmall
        fallback = user.teacher? ? 'profesor_small.png' : 'alumno_small.png'
        image_tag(user.avatar_file.blank?  ? fallback : user.avatar_file.xsmall.url)
    end
  end
  
  def members_active
    if controller_name == "courses" && action_name == "members"
      "active"
    end
  end
  
end
