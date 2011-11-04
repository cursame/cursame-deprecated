class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    comment      = commentable.comments.build params[:comment]
    comment.user = current_user
    if comment.save
      redirect_to commentable_path_for(comment) + "#comment_#{comment.id}", :notice => I18n.t('flash.comment_added')
    else
      redirect_to commentable_path_for(comment)
    end
  end

  def destroy
    comment = Comment.find params[:id]
    if current_user.can_manage_comment?(comment)
      comment.destroy
      redirect_to comment.commentable, :notice => t('flash.comment_deleted')
    end
  end

  private
  def commentable
    @commentable ||= 
      case params[:conditions][:commentable]
      when :assignment
        current_user.assignments.find params[:commentable_id]
      when :comment
        comment = Comment.find params[:commentable_id]
        raise ActiveRecord::RecordNotFound unless current_user.can_view_comment?(comment)
        comment
      end
  end

  def commentable_path_for comment
    Comment === comment.commentable ? commentable_path_for(comment.commentable) : polymorphic_path(comment.commentable)
  end
end
