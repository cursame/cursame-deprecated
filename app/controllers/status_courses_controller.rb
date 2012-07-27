class StatusCoursesController < ApplicationController
  # GET /status_courses
  # GET /status_courses.json
 
  def new
    @status_course = StatusCourse.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @status_course }
    end
  end

  # GET /status_courses/1/edit
  def edit
    @status_course = StatusCourse.find(params[:id])
  end

  # POST /status_courses
  # POST /status_courses.json
  def create
    @status_course = StatusCourse.new(params[:status_course])

    respond_to do |format|
      if @status_course.save
         @course = @status_course.course
         @course.status = @status_course.status
         @course.save
        format.html { redirect_to :back, notice: 'Se ha aceptado la orden de status del curso' }
        format.json { render json: @status_course, status: :created, location: @status_course }
      else
        format.html { render action: "new" }
        format.json { render json: @status_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /status_courses/1
  # PUT /status_courses/1.json
  def update
    @status_course = StatusCourse.find(params[:id])

    respond_to do |format|
      if @status_course.update_attributes(params[:status_course])
        format.html { redirect_to @status_course, notice: 'Status course was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @status_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /status_courses/1
  # DELETE /status_courses/1.json
  def destroy
    @status_course = StatusCourse.find(params[:id])
    @status_course.destroy

    respond_to do |format|
      format.html { redirect_to status_courses_url }
      format.json { head :ok }
    end
  end
end
