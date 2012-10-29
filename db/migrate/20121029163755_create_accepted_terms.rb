class CreateAcceptedTerms < ActiveRecord::Migration
  def change
    create_table :accepted_terms do |t|
      t.integer :user
      t.string :acepted
      t.date :date

      t.timestamps
    end
  end
end
