#encoding: utf-8
require 'spec_helper'


feature 'Notifications display', %q{
  In order to keep up to date
  As a user
  I want to see my notifications
} do

  background do
    @network = Factory :network
    @user    = Factory :user, :networks => [@network]
  end

  scenario 'viewing notification for student course enrollment' do
    notification = Factory(:student_course_enrollment, :user => @user)
    student      = notification.notificator.user
    course       = notification.notificator.course
    sign_in_with notification.user, :subdomain => @network.subdomain
    visit dashboard_path

    page.should have_content "#{student.name} quiere participar en el curso #{course.name}. Ver solicitudes"

    within '.notification' do
      page.should link_to user_path(student)
      page.should link_to course_path(course)
      page.should link_to members_for_course_path(course)
      page.should have_css(".notification-link")
    end
  end

  scenario 'viewing a notification for student delivery' do
    notification = Factory(:student_assignment_delivery, :user => @user)
    delivery   = notification.notificator
    student    = delivery.user
    assignment = delivery.assignment

    sign_in_with notification.user, :subdomain => @network.subdomain
    visit dashboard_path
    
    page.should have_content "#{student.name} ha entregado la tarea #{assignment.name}. Ver entrega"
 
    within '.notification' do
      page.should link_to user_path(student)
      page.should link_to assignment_path(assignment)
      page.should link_to delivery_path(delivery)
      page.should have_css(".notification-link")
    end
  end

  scenario 'viewing a notification for an answered survey' do
    notification = Factory(:teacher_survey_replied, :user => @user)
    survey_reply = notification.notificator
    survey       = survey_reply.survey
    student      = survey_reply.user
    course       = survey_reply.course

    sign_in_with notification.user, :subdomain => @network.subdomain
    visit dashboard_path
    
    page.should have_content "#{student.name} ha contestado el cuestionario #{survey.name} para el curso #{course.name}. Ver respuestas"
    
    within '.notification' do
      page.should link_to user_path(student)
      page.should link_to survey_path(survey)
      page.should link_to course_path(course)
      page.should link_to reply_path(survey_reply)
      page.should have_css(".notification-link")
    end
  end

  scenario 'viewing a notification for an edited survey answers' do
    notification = Factory(:teacher_survey_updated, :user => @user)
    survey_reply = notification.notificator
    survey       = survey_reply.survey
    student      = survey_reply.user
    course       = survey_reply.course

    sign_in_with notification.user, :subdomain => @network.subdomain
    visit dashboard_path
    
    page.should have_content "#{student.name} ha actualizado sus respuestas para el cuestionario #{survey.name} para el curso #{course.name}. Ver respuestas"
    
    within '.notification' do
      page.should link_to user_path(student)
      page.should link_to survey_path(survey)
      page.should link_to course_path(course)
      page.should link_to reply_path(survey_reply)
      page.should have_css(".notification-link")
    end
  end

  # TODO: from here students, separate specs
  scenario 'viewing a notification for course rejection' do
    notification = Factory(:student_course_rejected, :user => @user)
    course       = notification.notificator.course
    sign_in_with notification.user, :subdomain => @network.subdomain
    visit dashboard_path
    
    page.should have_content "Tu solicitud para participar en el curso \"#{course.name}\" fue rechazada. Ver cursos"

    within '.notification' do
      page.should link_to courses_path
      page.should have_css(".notification-link")
    end
  end

  scenario 'viewing a notification for course acceptance' do
    notification = Factory(:student_course_accepted, :user => @user)
    course       = notification.notificator.course
    sign_in_with notification.user, :subdomain => @network.subdomain
    visit dashboard_path
    
    page.should have_content "Has sido aceptado para participar en el curso #{course.name}"

    within '.notification' do
      page.should link_to course_path(course)
    end
  end

  scenario 'viewing a notification for an assignment added to a course' do
    notification = Factory(:student_assignment_added, :user => @user)
    assignment   = notification.notificator
    course       = assignment.course

    sign_in_with notification.user, :subdomain => @network.subdomain
    visit dashboard_path
    
    page.should have_content "Se ha creado la tarea #{assignment.name} para el curso #{course.name}. Ver tarea"
    
    within '.notification' do
      page.should link_to course_path(course)
      page.should link_to assignment_path(assignment)
      page.should have_css(".notification-link")
    end
  end

  scenario 'viewing a notification for an updated assignment' do
    notification = Factory(:student_assignment_updated, :user => @user)
    assignment   = notification.notificator
    course       = assignment.course
    sign_in_with notification.user, :subdomain => @network.subdomain
    visit dashboard_path
    
    page.should have_content "Se ha actualizado la tarea #{assignment.name} para el curso #{course.name}. Ver tarea"
    
    within '.notification' do
      page.should link_to course_path(course)
      page.should link_to assignment_path(assignment)
      page.should have_css(".notification-link")
    end
  end

  scenario 'viewing a notification for an survey added to a course' do
    notification = Factory(:student_survey_added, :user => @user)
    survey   = notification.notificator
    course       = survey.course

    sign_in_with notification.user, :subdomain => @network.subdomain
    visit dashboard_path
    
    page.should have_content "Se ha creado el cuestionario #{survey.name} para el curso #{course.name}. Ver cuestionario"
    
    within '.notification' do
      page.should link_to course_path(course)
      page.should link_to survey_path(survey)
      page.should have_css(".notification-link")
    end
  end

  scenario 'viewing a notification for a comment on one of my comments' do
    notification = Factory(:user_comment_on_comment, :user => @user)
    commenter = notification.notificator.user
    
    sign_in_with notification.user, :subdomain => @network.subdomain
    visit dashboard_path 

    page.should have_content "#{commenter.name} ha comentado en uno de tus comentarios. Ver comentario"
    
    within '.notification' do
      page.should link_to user_path(commenter)
      page.should have_css(".notification-link")
    end
  end

  scenario 'viewing a notification for a new discussion created on one of my courses' do
    notification = Factory(:course_discussion_added, :user => @user)
    discussion = notification.notificator
    course = discussion.course
    
    sign_in_with notification.user, :subdomain => @network.subdomain
    visit dashboard_path 

    page.should have_content "#{I18n.t 'notifications.discussion_added'} #{discussion.title} #{I18n.t 'notifications.for_the_course'} #{course.name}. #{I18n.t('notifications.show_discussion')}"
    
    within '.notification' do
      page.should link_to discussion_path(discussion)
      page.should link_to course_path(course)
      page.should have_css(".notification-link")
    end
  end

  scenario 'viewing a notification for a new comment on a discussion of my groups' do
    notification = Factory(:user_comment_on_discussion, :user => @user)
    comment = notification.notificator
    discussion = comment.commentable
    user = comment.user
    
    sign_in_with notification.user, :subdomain => @network.subdomain
    visit dashboard_path 

    page.should have_content "#{user.name} #{I18n.t('notifications.has_posted_a_comment_on_discussion')} #{discussion.title}. #{I18n.t('notifications.show_discussion')}"
    
    within '.notification' do
      page.should link_to user_path(user)
      page.should link_to discussion_path(discussion)
      page.should have_css(".notification-link")
    end
  end

  scenario 'viewing a notification for a new comment on the wall of one of my courses' do
    notification = Factory(:user_comment_on_course, :user => @user)
    comment = notification.notificator
    course = comment.commentable
    user = comment.user
    
    sign_in_with notification.user, :subdomain => @network.subdomain
    visit dashboard_path 

    page.should have_content "#{user.name} #{I18n.t('notifications.has_posted_a_comment_on_course')} #{course.name}. #{I18n.t('notifications.show_comment')}"
    
    within '.notification' do
      page.should link_to user_path(user)
      page.should link_to wall_for_course_path(course)
      page.should link_to comment_path(comment)
      page.should have_css(".notification-link")
    end
  end

  scenario 'viewing a notification for a new comment on my wall' do
    notification = Factory(:user_comment_on_user, :user => @user)
    comment = notification.notificator
    user = comment.user
    
    sign_in_with notification.user, :subdomain => @network.subdomain
    visit dashboard_path 

    page.should have_content "#{user.name} #{I18n.t('notifications.has_posted_a_comment_on_user')}. #{I18n.t('notifications.show_comment')}"
    
    within '.notification' do
      page.should link_to user_path(user)
      page.should link_to comment_path(comment)
      page.should have_css(".notification-link")
    end
  end

end
