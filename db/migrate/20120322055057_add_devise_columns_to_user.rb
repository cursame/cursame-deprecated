class AddDeviseColumnsToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.token_authenticatable
    end
  end
  def self.down
    t.remove :token_authenticatable
  end
end