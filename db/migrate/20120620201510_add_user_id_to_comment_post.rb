class AddUserIdToCommentPost < ActiveRecord::Migration
  def change
    add_column :comment_posts, :user_id, :integer
  end
end
