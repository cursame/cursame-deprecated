class CommentsController < ApplicationController
  def create
    @comment = (User === commentable ? commentable.profile_comments : commentable.comments).build params[:comment]
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to commentable_path_for(@comment) + "#comment_#{@comment.id}", :notice => I18n.t('flash.comment_added') }
        format.js
      else
        format.html { redirect_to commentable_path_for(@comment) }
      end
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    if current_user.can_destroy_comment? @comment
      respond_to do |format|
        if @comment.destroy
          format.html {redirect_to commentable_path_for(@comment), :notice => t('flash.comment_deleted')}
          format.js
        end
      end
    end
  end
  
  def show
    @comment = Comment.find params[:id]
    @user = current_user
  end

  private
  def commentable
    @commentable ||=
      case params[:conditions][:commentable]
      when :assignment
        (current_user.supervisor? ? current_network.assignments.find(params[:commentable_id]) : current_user.assignments.find(params[:commentable_id]))
      when :course
        (current_user.supervisor? ? current_network.courses.find(params[:commentable_id]) : current_user.courses.order.find(params[:commentable_id]))
      when :discussion
        (current_user.supervisor? ? current_network.discussions.find(params[:commentable_id]) : current_user.discussions.find(params[:commentable_id]))
      when :user
        current_network.users.find params[:commentable_id]
      when :delivery
        Delivery.where(:user_id => current_user, :id => params[:commentable_id]).first ||
          current_user.manageable_deliveries.find(params[:commentable_id])
      when :comment
        comment = Comment.find params[:commentable_id]
        raise ActiveRecord::RecordNotFound unless current_user.can_view_comment?(comment)
        comment
      end
  end

  def commentable_path_for comment
    commentable = comment.commentable
    case commentable
    when Course
      wall_for_course_path commentable
    when User
      wall_for_user_path commentable
    when Delivery
      if commentable.user == current_user
        assignment_delivery_path commentable.assignment
      else
        delivery_path commentable
      end
    else
      Comment === commentable ? commentable_path_for(commentable) : polymorphic_path(commentable)
    end
  end
end
