class FixCourseLogoFileName < ActiveRecord::Migration
  def up
    rename_column :courses, :logo_file, :course_logo_file
  end

  def down
    rename_column :courses, :course_logo_file, :logo_file
  end
end
