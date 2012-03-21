class AddAcceptingEmailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :accepting_emails, :boolean, :default => true
  end
end
