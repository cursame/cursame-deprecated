class BugAnswer < ActiveRecord::Base
  belongs_to :send_report
  belongs_to :user
  
   validates_presence_of :container
   validates_presence_of :date
   validates_presence_of :send_report_id
   validates_presence_of :send_report_status
   validates_presence_of :user_id
end
