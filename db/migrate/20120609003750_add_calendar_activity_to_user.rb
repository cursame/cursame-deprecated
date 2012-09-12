class AddCalendarActivityToUser < ActiveRecord::Migration
  def change
    add_column :users, :calendar_activity, :string
  end
end
