class AddUserIdToSendReport < ActiveRecord::Migration
  def change
    add_column :send_reports, :user_id, :integer
  end
end
