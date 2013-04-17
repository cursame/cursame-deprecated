class AddTopUserScoreToUsers < ActiveRecord::Migration

  def up
     add_column :users, :top_user_score, :integer
  end

  def down
    remove_column :users, :top_user_score
  end

end
