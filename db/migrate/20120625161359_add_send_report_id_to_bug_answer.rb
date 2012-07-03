class AddSendReportIdToBugAnswer < ActiveRecord::Migration
  def change
    add_column :bug_answers, :send_report_id, :integer
  end
end
