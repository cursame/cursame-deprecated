class BugAnswersController < ApplicationController

  def new
    @bug_answer = BugAnswer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bug_answer }
    end
  end

  # GET /bug_answers/1/edit
  def edit
    @bug_answer = BugAnswer.find(params[:id])
  end

  # POST /bug_answers
  # POST /bug_answers.json
  def create
    @bug_answer = BugAnswer.new(params[:bug_answer])
    respond_to do |format|
      if @bug_answer.save
         @send_report = @bug_answer.send_report
         @send_report.status = @bug_answer.send_report_status
         @send_report.save
        format.html { redirect_to :back, notice: 'Bug answer was successfully created.' }
        format.json { render json: @bug_answer, status: :created, location: @bug_answer }
      else
        format.html { render action: "new" }
        format.json { render json: @bug_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bug_answers/1
  # PUT /bug_answers/1.json
  def update
    @bug_answer = BugAnswer.find(params[:id])
       
    respond_to do |format|
      if @bug_answer.update_attributes(params[:bug_answer])
        format.html { redirect_to @bug_answer, notice: 'Bug answer was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bug_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bug_answers/1
  # DELETE /bug_answers/1.json
  def destroy
    @bug_answer = BugAnswer.find(params[:id])
    @bug_answer.destroy

    respond_to do |format|
      format.html { redirect_to bug_answers_url }
      format.json { head :ok }
    end
  end
end
