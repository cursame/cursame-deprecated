class CreateLikeNotLikes < ActiveRecord::Migration
  def change
    create_table :like_not_likes do |t|
      t.integer :like
      t.integer :user_id

      t.timestamps
    end
  end
end
