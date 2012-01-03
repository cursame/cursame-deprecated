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

  factory :wrong_survey_reply, :parent => :survey_reply do
    survey_answers_attributes do |reply|
      reply.survey.questions.map do |question|
        {:question_id => question.id, :answer_uuid => question.answers.find { |answer|
          answer != question.correct_answer  
        }
        }
      end
    end
  end
end
