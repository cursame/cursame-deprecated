require 'spec_helper'

describe SurveyAnswer do
  it { should belong_to :survey_reply }
  it { should belong_to :answer }

  describe 'correctness' do
    before do
      @question = Factory(:question)
      @question.correct_answer.should_not be_nil
    end

    describe 'is correct' do
      before do
        @survey_reply = SurveyAnswer.new(:question => @question, :answer => @question.correct_answer)
      end
      it { @survey_reply.should be_correct }
      it { @survey_reply.score.should == @question.value }
      it { @survey_reply.state.should == 'correct' }
    end

    describe 'is not correct' do
      before do
        @survey_reply = SurveyAnswer.new(:question => @question, :answer => @question.answers.all.find{ |q| @question.correct_answer != q} )
      end
      it { @survey_reply.should_not be_correct }
      it { @survey_reply.score.should == 0 }
      it { @survey_reply.state.should == 'incorrect' }
    end
  end
end
