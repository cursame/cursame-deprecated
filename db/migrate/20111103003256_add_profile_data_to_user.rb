class AddProfileDataToUser < ActiveRecord::Migration
  def change
    add_column :users, :about_me,      :text
    add_column :users, :studies,       :text
    add_column :users, :birth_date,    :date
    add_column :users, :occupation,    :text
    add_column :users, :twitter_link,  :string
    add_column :users, :facebook_link, :string
    add_column :users, :linkedin_link, :string
  end
end
