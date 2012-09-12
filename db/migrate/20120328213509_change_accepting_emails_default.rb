class ChangeAcceptingEmailsDefault < ActiveRecord::Migration
  def up
    change_column_default :users, :accepting_emails, false
  end

  def down
    change_column_default :users, :accepting_emails, true
  end
end
