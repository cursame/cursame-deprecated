class SendReportsController < ApplicationController

  # POST /send_reports
  # POST /send_reports.json
  def create
    @send_report = SendReport.new(params[:send_report])

    respond_to do |format|
      if @send_report.save
        format.html { redirect_to soporte_path, notice: 'Tu tiket de soporte se ha enviado tendras una respuesta en las siguientes 24 horas' }
        format.json { render json: soporte_path, status: :created, location: @send_report }
      else
        format.html { redirect_to soporte_path, notice: 'Tu tiket no se pudo guardar porque alguno de los campos esta vacio' }
        format.json { render json: soporte_path, status: :created, location: @send_report }
      end
    end
  end

  # PUT /send_reports/1
  # PUT /send_reports/1.json
  def update
    @send_report = SendReport.find(params[:id])

    respond_to do |format|
      if @send_report.update_attributes(params[:send_report])
        format.html { redirect_to @send_report, notice: 'Send report was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @send_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /send_reports/1
  # DELETE /send_reports/1.json
  def destroy
    @send_report = SendReport.find(params[:id])
    @send_report.destroy

    respond_to do |format|
      format.html { redirect_to send_reports_url }
      format.json { head :ok }
    end
  end
  
end
