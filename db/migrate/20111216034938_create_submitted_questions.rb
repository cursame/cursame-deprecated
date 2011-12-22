class CreateSubmittedQuestions < ActiveRecord::Migration
  def change
    create_table :submitted_questions do |t|
      t.references :submitted_survey
      t.references :question
      t.string     :answer_uuid, :limit => 36
      t.timestamps
    end
  end
end
