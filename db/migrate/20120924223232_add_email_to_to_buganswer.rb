class AddEmailToToBuganswer < ActiveRecord::Migration
  def change
    add_column :bug_answers, :email_to, :string
  end
end
