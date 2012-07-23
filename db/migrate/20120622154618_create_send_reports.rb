class CreateSendReports < ActiveRecord::Migration
  def change
    create_table :send_reports do |t|
      t.string :title
      t.text :text
      t.datetime :event_date

      t.timestamps
    end
  end
end
