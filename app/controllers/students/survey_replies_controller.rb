class Students::SurveyRepliesController < ApplicationController
  def show
    @survey_reply = current_user.survey_replies.where(:survey_id => params[:survey_id]).first
    @survey = @survey_reply.survey
    @course = @survey_reply.course
    @reveal_answers = @survey.due_to < Time.now
    @tutoriales = Tutoriale.all
  end

  def new
    @survey = current_user.surveys.published.find params[:survey_id]
    @course = @survey.course
    @survey_reply = current_user.survey_replies.build(:survey => @survey)
    @tutoriales = Tutoriale.all
    @survey.questions.each do |question|
      @survey_reply.survey_answers.build :question => question
    end
  end

  def create
    @survey = current_user.surveys.published.find params[:survey_id]
    @survey_reply = current_user.survey_replies.build(params[:survey_reply])
    @survey_reply.survey = @survey
    if @survey_reply.save
      reply = SurveyReply.find_by_user_id current_user
      min, max = reply.score, @survey.value
      if (reply.score < (@survey.value)/0.8)
        notice = "Resultado no satisfactorio, tu calificaci\u00f3n es #{min} de #{max}. " +
		 "Sigue capacit\u00e1ndote consultando toda la informaci\u00f3n que tenemos para ti en la secci\u00f3n de Campa\u00f1as y en Experto Movistar"
        redirect_to survey_reply_path(@survey), :notice => notice 
        #redirect_to survey_reply_path(@survey), :notice => t('survey_failed', :min => min, :max => max)
      else
        notice = "\u00A1Felicidades! Tu calificaci\u00f3n es #{min} de #{max}. " + 
                 "\u00A1Capac\u00edtate! Consulta la secci\u00f3n de campa\u00f1as que contiene informaci\u00f3n que te ayudar\u00e1 para obtener un mejor resultado. " +
                 "Tambi\u00e9n puedes utilizar la informaci\u00f3n de Experto Movistar."
        redirect_to survey_reply_path(@survey), :notice => notice
        #redirect_to survey_reply_path(@survey), :notice => t('survey_approved', :min => min, :max => max)
      end
    else
      @course = @survey.course
      render :new
    end
  end

  def edit
    @survey_reply = current_user.survey_replies.where(:survey_id => params[:survey_id]).first
    @survey = @survey_reply.survey
    @course = @survey_reply.course
    @tutoriales = Tutoriale.all
  end

  def update
    @survey_reply = current_user.survey_replies.where(:survey_id => params[:survey_id]).first
    @survey = @survey_reply.survey
    @course = @survey_reply.course

    if @survey_reply.update_attributes params[:survey_reply]
      reply = SurveyReply.find_by_user_id current_user
      min, max = reply.score, @survey.value
      if (reply.score < (@survey.value)/0.8)
         notice = "Resultado no satisfactorio, tu calificaci\u00f3n es #{min} de #{max}. " +
                  "Sigue capacit\u00e1ndote consultando toda la informaci\u00f3n que tenemos para ti en la secci\u00f3n de Campa\u00f1as y en Experto Movistar"
         redirect_to survey_reply_path(@survey), :notice => notice 
         #redirect_to survey_reply_path(@survey), :notice => t('survey_failed', :min => min, :max => max)
       else
         notice = "\u00A1Felicidades! Tu calificaci\u00f3n es #{min} de #{max}. " + 
                  "\u00A1Capac\u00edtate! Consulta la secci\u00f3n de campa\u00f1as que contiene informaci\u00f3n que te ayudar\u00e1 para obtener un mejor resultado. " +
                  "Tambi\u00e9n puedes utilizar la informaci\u00f3n de Experto Movistar."
         redirect_to survey_reply_path(@survey), :notice => notice
         #redirect_to survey_reply_path(@survey), :notice => t('survey_approved', :min => min, :max => max)
       end
    else
      render :edit
    end
  end
end
