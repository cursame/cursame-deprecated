class AddSendReportStatusToBugAnswer < ActiveRecord::Migration
  def change
    add_column :bug_answers, :send_report_status, :string
  end
end
