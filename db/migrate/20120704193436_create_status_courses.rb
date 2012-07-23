class CreateStatusCourses < ActiveRecord::Migration
  def change
    create_table :status_courses do |t|
      t.string :status
      t.date :date
      t.integer :course_id

      t.timestamps
    end
  end
end
