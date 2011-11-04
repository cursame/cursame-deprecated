class SupervisorsController < ApplicationController
  before_filter :authenticate_supervisor!
  before_filter :require_network

  def show
  end


  def courses
    @courses = current_network.courses
  end


  def teachers
    @teachers = current_network.teachers
  end


  def students
    @students = current_network.students
  end
end
