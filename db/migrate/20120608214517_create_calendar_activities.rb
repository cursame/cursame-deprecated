class CreateCalendarActivities < ActiveRecord::Migration
  def change
    create_table :calendar_activities do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
