class CreateNewUsersChangeTypes < ActiveRecord::Migration
  def change
    create_table :new_users_change_types do |t|
      t.integer :new_old
      t.integer :user_id

      t.timestamps
    end
  end
end
