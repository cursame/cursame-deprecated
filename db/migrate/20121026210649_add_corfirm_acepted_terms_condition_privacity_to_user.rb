class AddCorfirmAceptedTermsConditionPrivacityToUser < ActiveRecord::Migration
  def change
    add_column :users, :corfirm_acepted_terms_condition_privacity, :string
  end
end
