class AddCourseIdToChat < ActiveRecord::Migration
  def change
    add_column :chats, :course_id, :integer
  end
end
