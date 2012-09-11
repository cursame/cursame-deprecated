class CreateAssignations < ActiveRecord::Migration
  def change
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
