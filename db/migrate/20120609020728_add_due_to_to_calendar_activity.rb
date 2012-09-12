class AddDueToToCalendarActivity < ActiveRecord::Migration
  def change
    add_column :calendar_activities, :due_to, :datetime
  end
end
