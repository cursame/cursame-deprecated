class Favorite < ActiveRecord::Base
  has_and_belongs_to_many :users
  def self.up
           rename_table :favorites, :favorites_users
       end 
   def self.down
           rename_table :favorites, :favorites_users
   end
  
end
