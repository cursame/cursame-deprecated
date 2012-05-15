class AddCourseToChat < ActiveRecord::Migration
  def change
    add_column :chats, :course, :string
  end
end
