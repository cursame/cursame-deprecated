class CreateCourseAssets < ActiveRecord::Migration
  def change
    create_table :course_assets do |t|
      t.references :course
      t.string     :file
      t.string     :content_type
      t.timestamps
    end
  end
end
