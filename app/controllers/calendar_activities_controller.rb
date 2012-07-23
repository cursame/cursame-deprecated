class CalendarActivitiesController < ApplicationController
  

  # POST /calendar_activities
  # POST /calendar_activities.json
  def create
    @calendar_activity = CalendarActivity.new(params[:calendar_activity])

    respond_to do |format|
      if @calendar_activity.save
        format.html { redirect_to :back, notice: 'La actividad fue agregada al calendario satisfactoriamente.' }
        format.json { render json: @calendar_activity, status: :created, location: @calendar_activity }
      else
        format.html { redirect_to :back, notice: 'La actividad no fue creada correctamente debido a que algunos de los campos estaban vacios' }
        format.json { render json: @calendar_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /calendar_activities/1
  # PUT /calendar_activities/1.json
  def update
    @calendar_activity = CalendarActivity.find(params[:id])

    respond_to do |format|
      if @calendar_activity.update_attributes(params[:calendar_activity])
        format.html { redirect_to @calendar_activity, notice: 'Calendar activity was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @calendar_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /current_user.calendar_activities/1
  # DELETE /current_user.calendar_activities/1.json
  def destroy
    @calendar_activity = CalendarActivity.find(params[:id])
    @calendar_activity.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :ok }
    end
  end
  def show
      @calendar_activity = CalendarActivity.find(params[:id])
  end
end
