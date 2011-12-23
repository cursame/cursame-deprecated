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
      when :xxsmall
        fallback = user.teacher? ? 'profesor_xsmall.png' : 'alumno_xsmall.png'
        image_tag(user.avatar_file.blank?  ? fallback : user.avatar_file.xxsmall.url)
    end
  end
  
  def members_active
    if controller_name == "courses" && action_name == "members"
      "active"
    end
  end

  def notification_message notification
    self.send notification.kind, notification
  end

  def student_course_enrollment notification
    notificator = notification.notificator
    course      = notificator.course
    student     = notificator.user 

    t notification.kind, :scope => 'notifications',
      :student_image => link_to(avatar(student, :xxsmall), user_url(student), :rel => "tip", :title => student.name),
      :student_link  => link_to(student.name, user_url(student)),
      :course_link   => link_to(course.name, course_url(course)),
      :members_link => link_to(t('notifications.show_requests') + " >>", members_for_course_url(notificator.course))
  end

  def student_assignment_delivery notification
    delivery   = notification.notificator
    student    = delivery.user
    assignment = delivery.assignment

    t notification.kind, :scope => 'notifications', 
      :student_image    => link_to(avatar(student, :xxsmall), user_url(student), :rel => "tip", :title => student.name),
      :student_link     => link_to(student.name, user_url(student)),
      :assignment_link  => link_to(assignment.name, assignment_url(assignment)),
      :delivery_link    => link_to(t('notifications.show_delivery') + " >>", delivery_url(delivery))
  end

  def student_course_rejected notification
    course = notification.notificator.course

    t notification.kind, :scope => 'notifications', 
      :course_name  => course.name,
      :courses_link => link_to(t('notifications.show_courses') + " >>", courses_url)
  end

  def student_course_accepted notification
    course = notification.notificator.course

    t notification.kind, :scope => 'notifications', 
      :course_link => link_to(course.name + " >>", course_url(course))
  end

  def student_assignment_added notification
    assignment   = notification.notificator
    course       = assignment.course
    t notification.kind, :scope => 'notifications', 
      :course_link => link_to(course.name, course_url(course)),
      :assignment_link => link_to(assignment.name, assignment_url(assignment)),
      :show_assignment_link => link_to(t('notifications.show_assignment') + " >>", assignment_url(assignment))
  end

  def student_assignment_updated notification
    assignment   = notification.notificator
    course       = assignment.course
    t notification.kind, :scope => 'notifications', 
      :course_link => link_to(course.name, course_url(course)),
      :assignment_link => link_to(assignment.name, assignment_url(assignment)),
      :show_assignment_link => link_to(t('notifications.show_assignment') + " >>", assignment_url(assignment))
  end

  def student_survey_added notification
    survey  = notification.notificator
    course  = survey.course
    t notification.kind, :scope => 'notifications', 
      :course_link => link_to(course.name, course_url(course)),
      :survey_link => link_to(survey.name, survey_url(survey)),
      :show_survey_link => link_to(t('notifications.show_survey') + " >>", survey_url(survey))
  end

  def student_survey_updated notification
    survey  = notification.notificator
    course  = survey.course
    t notification.kind, :scope => 'notifications', 
      :course_link => link_to(course.name, course_url(course)),
      :survey_link => link_to(survey.name, survey_url(survey)),
      :show_survey_link => link_to(t('notifications.show_survey') + " >>", survey_url(survey))
  end

  # TODO: refactor student_image + student_link into helper
  def teacher_survey_replied notification
    survey_reply = notification.notificator
    survey  = survey_reply.survey
    course  = survey_reply.course
    student = survey_reply.user
    t notification.kind, :scope => 'notifications', 
      :student_image     => link_to(avatar(student, :xxsmall), user_url(student), :rel => "tip", :title => student.name),
      :student_link      => link_to(student.name, user_url(student)),
      :survey_link       => link_to(survey.name, survey_url(survey)),
      :course_link       => link_to(course.name, course_url(course)),
      :survey_reply_link => link_to(t('notifications.show_survey_reply') + " >>", reply_url(survey_reply))
  end
end
