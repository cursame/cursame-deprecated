class DiscussionsController < ApplicationController
  def new
    @discussion = course.discussions.build
  end

  def index
    @discussions = course.discussions
  end

  def create
    @discussion = course.discussions.build params[:discussion]
    @discussion.starter = current_user
    if @discussion.save
      redirect_to @discussion, :notice => I18n.t('flash.discussion_created')
    else
      render 'new'
    end
  end

  def show
    @discussion = current_user.discussions.find params[:id]
  end

  def edit
    @discussion = manageable_discussion
  end

  def destroy
    manageable_discussion.destroy
    redirect_to course_discussions_path(manageable_discussion.course), :notice => t('flash.discussion_deleted')
  end

  def update
    @discussion = manageable_discussion

    if @discussion.update_attributes params[:discussion]
      redirect_to @discussion, :notice => I18n.t('flash.discussion_updated')
    else
      render 'edit'
    end
  end

  private
  def course
    @course ||= current_user.courses.find params[:course_id]
  end
  
  def manageable_discussion
    @manageable_discussions ||= current_user.manageable_discussions.find params[:id]
  end
end
