module ApplicationHelper
  
  def course_members(model)
    numbers = model.students.count
    members = numbers == 1 ? t('courses.members.member') : t('courses.members.members')
    result = "#{numbers} #{members}"
  end
  
  def avatar(user, size=nil)
    case size
      when 180 then image_tag(user.has_avatar? ? user.avatar_file.size.url : 'professor.jpg')
      when 40 then image_tag(user.has_avatar? ? user.avatar_file.size.url : 'professor_small.jpg')
    end
  end
  
end
