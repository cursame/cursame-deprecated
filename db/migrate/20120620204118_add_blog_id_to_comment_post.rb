class AddBlogIdToCommentPost < ActiveRecord::Migration
  def change
    add_column :comment_posts, :blog_id, :integer
  end
end
