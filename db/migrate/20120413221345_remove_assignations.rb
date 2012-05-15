class RemoveAssignations < ActiveRecord::Migration
  def up
    drop_table :assignations 
  end

  def down
    create_table :assignations do |t|
      t.references :user
      t.references :course
      t.boolean    :admin

      t.timestamps
    end

    add_index :assignations, :user_id
    add_index :assignations, :course_id
  end
end
