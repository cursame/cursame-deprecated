class AddUserIdToBugAnswer < ActiveRecord::Migration
  def change
    add_column :bug_answers, :user_id, :integer
  end
end
