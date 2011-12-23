FactoryGirl.define do
  factory :survey_reply do
    survey { Factory(:survey) }
    user   { Factory(:user) }
    survey_answers_attributes do |reply|
      reply.survey.questions.map do |question|
        {:question_id => question.id, :answer_uuid => question.correct_answer.uuid}
      end
    end
  end
end
