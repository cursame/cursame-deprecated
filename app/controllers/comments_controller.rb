class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    comment      = commentable.comments.build params[:comment]
    comment.user = current_user
    if comment.save
      redirect_to polymorphic_path(commentable) + "#comment_#{comment.id}", :notice => I18n.t('flash.comment_added')
    else
      redirect_to polymorphic_path(commentable)
    end
  end
  
  private
  def commentable
    @commentable ||= 
      case params[:conditions][:commentable]
      when :assignment
        current_user.assignments.find params[:commentable_id]
      end
  end
end
