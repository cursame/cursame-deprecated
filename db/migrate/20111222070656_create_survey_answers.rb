class CreateSurveyAnswers < ActiveRecord::Migration
  def change
    create_table :survey_answers do |t|
      t.references :survey_reply
      t.references :question
      t.string :answer_uuid
      t.timestamps
    end
  end
end
