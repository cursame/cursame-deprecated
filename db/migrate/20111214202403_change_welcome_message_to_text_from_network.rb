class ChangeWelcomeMessageToTextFromNetwork < ActiveRecord::Migration
  def up
    change_column :networks, :welcome_message, :text
  end

  def down
    change_column :networks, :welcome_message, :string
  end
end
