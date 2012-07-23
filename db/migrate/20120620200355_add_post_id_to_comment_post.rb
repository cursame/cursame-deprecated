class AddPostIdToCommentPost < ActiveRecord::Migration
  def change
    add_column :comment_posts, :post_id, :integer
  end
end
