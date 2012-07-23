class AddCommentIdToLikeNotLike < ActiveRecord::Migration
  def change
    add_column :like_not_likes, :comment_id, :integer
  end
end
