class AddDateActivityToCalendarActivity < ActiveRecord::Migration
  def change
    add_column :calendar_activities, :date_activity, :date
  end
end
