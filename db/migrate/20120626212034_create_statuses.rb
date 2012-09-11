class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :view_status
      t.date :date_status

      t.timestamps
    end
  end
end
