class CreateSubmittedSurveys < ActiveRecord::Migration
  def change
    create_table :submitted_surveys do |t|
      t.references :survey
      t.references :user
      t.timestamps
    end
  end
end
