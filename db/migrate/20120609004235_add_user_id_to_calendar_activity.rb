class AddUserIdToCalendarActivity < ActiveRecord::Migration
  def change
    add_column :calendar_activities, :user_id, :integer
  end
end
