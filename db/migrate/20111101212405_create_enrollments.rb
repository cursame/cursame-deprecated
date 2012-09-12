class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.references :user
      t.references :course
      t.string     :state

      t.timestamps
    end

    add_index :enrollments, :user_id
    add_index :enrollments, :course_id
  end
end
