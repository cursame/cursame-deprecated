class ChangeAcceptinMailsValue < ActiveRecord::Migration
  def up
    User.update_all ["accepting_emails = ?", true]
  end

  def down
    
  end
end
