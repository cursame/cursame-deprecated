class AddSubdomainToBuganswer < ActiveRecord::Migration
  def change
    add_column :bug_answers, :subdomain, :string
  end
end
