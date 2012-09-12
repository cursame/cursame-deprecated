class AddUserToCalendarActivity < ActiveRecord::Migration
  def change
    add_column :calendar_activities, :user, :string
  end
end
