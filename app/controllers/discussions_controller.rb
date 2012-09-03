class DiscussionsController < ApplicationController
  set_tab :discussions
  
  def new
    @discussion = course.discussions.build
    @tutoriales = Tutoriale.all
    @banner = Banner.last
  end

  def index
    @course, @discussions = course, course.discussions
    @tutoriales = Tutoriale.all
    @banner = Banner.last
  end

  def create
    @discussion = course.discussions.build params[:discussion]
    @discussion.starter = current_user
    if @discussion.save
      Innsights.report("Discusión creada", :user => current_user, :group => current_network).run
      redirect_to @discussion, :notice => I18n.t('flash.discussion_created')
    else
      render 'new'
    end
  end

  def show
    @discussion = accessible_discussions.find params[:id]
    @course     = @discussion.course
    @comments   = @discussion.comments.order("created_at DESC").page(params[:page]).per(10)
    @tutoriales = Tutoriale.all
    @banner = Banner.last
  end

  def edit
    @discussion = manageable_discussion
    @course     = @discussion.course
  end

  def destroy
    if manageable_discussion.comments.empty?
      manageable_discussion.destroy
      Innsights.report("Discusión eliminada", :user => current_user, :group => current_network).run
      flash[:notice] = t('flash.discussion_deleted')
    end

    redirect_to course_discussions_path manageable_discussion.course
  end

  def update
    @discussion = manageable_discussion

    if @discussion.update_attributes params[:discussion]
      Innsights.report("Discusión actualizada", :user => current_user, :group => current_network).run
      redirect_to @discussion, :notice => I18n.t('flash.discussion_updated')
    else
      render 'edit'
    end
  end

  private
  def course
    @course ||= accessible_courses.find params[:course_id]
  end

  def accessible_discussions
    current_user.supervisor? ? current_network.discussions : current_user.discussions
  end
  
  def manageable_discussion
    @manageable_discussions ||= current_user.manageable_discussions.find params[:id]
  end
end
