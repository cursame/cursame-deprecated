class CalificationemsController < ApplicationController
  def create
    @calificationem = Calificationem.new(params[:calificationem])
  
    respond_to do |format|
      if @calificationem.save
         @delivery=@calificationem.delivery
         @delivery.calificationem_id=@calificationem.id
         @delivery.raiting=@calificationem.raiting
         @delivery.anotation_coment=@calificationem.anotation_coment
         @delivery.save
        format.html { redirect_to :back, notice: 'Calificationem was successfully created.' }
        format.json { render json: @calificationem, status: :created, location: @calificationem }
      else
        format.html { render action: "new" }
        format.json { render json: @calificationem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /calificationems/1
  # PUT /calificationems/1.json
  def update
    @calificationem = Calificationem.find(params[:id])
    @calificationem.delivery.calificationem_id = @calificationem.id
    @calificationem.delivery.save
    respond_to do |format|
      if @calificationem.update_attributes(params[:calificationem])
        format.html { redirect_to :back, notice: 'Calificationem was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @calificationem.errors, status: :unprocessable_entity }
      end
    end
  end
private
 def course
   @course ||= accessible_courses.find params[:course_id]
 end
 
 
end
