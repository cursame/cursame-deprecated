class SetDeafaultToUsers < ActiveRecord::Migration
  def up
    change_column_default(:users, :accepting_emails, true)
  end

  def down
    change_column_default(:users, :accepting_emails, false)
  end
end
