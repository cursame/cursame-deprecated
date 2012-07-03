class BugAnswer < ActiveRecord::Base
  belongs_to :send_report
  belongs_to :user
end
