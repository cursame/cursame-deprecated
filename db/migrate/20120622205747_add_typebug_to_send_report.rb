class AddTypebugToSendReport < ActiveRecord::Migration
  def change
    add_column :send_reports, :typebug, :string
  end
end
