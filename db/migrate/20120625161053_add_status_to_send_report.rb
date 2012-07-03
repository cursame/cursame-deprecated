class AddStatusToSendReport < ActiveRecord::Migration
  def change
    add_column :send_reports, :status, :string
  end
end
