require 'acceptance/acceptance_helper'

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
      page.should link_to course_requests_path(course)
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
    end
  end

  # TODO: from here students
  scenario 'viewing a notification for course rejection' do
    notification = Factory(:student_course_rejected, :user => @user)
    course       = notification.notificator.course
    sign_in_with notification.user, :subdomain => @network.subdomain
    visit dashboard_path
    
    page.should have_content "Tu solicitud para participar en el curso \"#{course.name}\" fue rechazada. Ver cursos"

    within '.notification' do
      page.should link_to courses_path
    end
  end

  scenario 'viewing a notification for course rejection' do
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
    
    page.should have_content "Se ha creado la tarea #{assignment.name} en #{course.name}. Ver tarea"
    
    within '.notification' do
      page.should link_to course_path(course)
      page.should link_to assignment_path(assignment)
    end
  end

  scenario 'viewing a notification for an updated assignment' do
    notification = Factory(:student_assignment_updated, :user => @user)
    assignment   = notification.notificator
    course       = assignment.course

    sign_in_with notification.user, :subdomain => @network.subdomain
    visit dashboard_path
    
    page.should have_content "Se ha actualizado la tarea #{assignment.name} en #{course.name}. Ver tarea"
    
    within '.notification' do
      page.should link_to course_path(course)
      page.should link_to assignment_path(assignment)
    end
  end

  scenario 'viewing a notification for an survey added to a course' do
    notification = Factory(:student_survey_added, :user => @user)
    survey   = notification.notificator
    course       = survey.course

    sign_in_with notification.user, :subdomain => @network.subdomain
    visit dashboard_path
    save_and_open_page
    
    page.should have_content "Se ha creado el cuestionario #{survey.name} en #{course.name}. Ver cuestionario"
    
    within '.notification' do
      page.should link_to course_path(course)
      page.should link_to survey_path(survey)
    end
  end

  scenario 'viewing a notification for an updated survey' do
    notification = Factory(:student_survey_updated, :user => @user)
    survey   = notification.notificator
    course       = survey.course

    sign_in_with notification.user, :subdomain => @network.subdomain
    visit dashboard_path
    save_and_open_page
    
    page.should have_content "Se ha actualizado el cuestionario #{survey.name} en #{course.name}. Ver cuestionario"
    
    within '.notification' do
      page.should link_to course_path(course)
      page.should link_to survey_path(survey)
    end
  end
end
