class RenameCourseAssets < ActiveRecord::Migration
  def self.up
    rename_table :course_assets, :assets
  end 
  def self.down
    rename_table :assets, :course_assets
  end
end
