class AddUserToCommentPost < ActiveRecord::Migration
  def change
    add_column :comment_posts, :user, :string
  end
end
