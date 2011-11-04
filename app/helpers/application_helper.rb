module ApplicationHelper
  
  def course_members(model)
    numbers = model.users.count
    members = numbers == 1 ? t('courses.members.member') : t('courses.members.members')
    result = "#{numbers} #{members}"
  end
  
  def avatar
    
  end
  
end
