class CreateCommentPosts < ActiveRecord::Migration
  def change
    create_table :comment_posts do |t|
      t.string :title
      t.text :content
      t.date :date

      t.timestamps
    end
  end
end
