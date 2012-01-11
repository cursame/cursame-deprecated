require 'spec_helper'

describe SurveyReply do
  let(:survey_reply) { Factory.build(:survey_reply) }
  it { survey_reply.valid? or raise survey_reply.errors.inspect }

  it { should belong_to :survey }
  it { should belong_to :user }
  it { should have_many(:survey_answers).dependent(:destroy) }

  it 'should provide a score' do
    question = Factory(:question, :value => 1)
    survey_reply.survey.questions << question
    survey_reply.survey_answers.build(:question => question) # unanswered
    survey_reply.survey.should have(2).questions
    survey_reply.survey.questions.each { |q| q.value.should == 1}
    survey_reply.should have(2).survey_answers
    survey_reply.save!
    survey_reply.score.should == 5.0
  end

  describe 'validations' do
    let(:student) { Factory(:student) }
    subject { Factory.build(:survey_reply, :user => @student) }
    
    it { subject.save! and should validate_uniqueness_of(:survey_id) }

    it 'should not allow survey_reply when date is due' do
      subject.should be_valid
      Timecop.freeze(6.month.from_now) do
        subject.should_not be_valid
        subject.errors[:base].should include('Due date has passed')
      end
    end
  end
end
