class CreateSurveyReplies < ActiveRecord::Migration
  def change
    create_table :survey_replies do |t|
      t.references :user
      t.references :survey
      t.timestamps
    end
  end
end
