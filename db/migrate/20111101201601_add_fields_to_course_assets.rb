class AddFieldsToCourseAssets < ActiveRecord::Migration
  def change
    add_column :course_assets, :name, :string
    add_column :course_assets, :description, :string
  end
end
