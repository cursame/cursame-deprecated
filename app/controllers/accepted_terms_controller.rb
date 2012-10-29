class AcceptedTermsController < ApplicationController
  # GET /accepted_terms
  # GET /accepted_terms.json
  def index
    @accepted_term = AcceptedTerm.new
  end  

  # GET /accepted_terms/new
  # GET /accepted_terms/new.json
  def new
    @accepted_term = AcceptedTerm.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @accepted_term }
    end
  end

  def create
    @accepted_term = AcceptedTerm.new(params[:accepted_term])
    respond_to do |format|
      if @accepted_term.save
         @user =  @accepted_term.user
         @user.corfirm_acepted_terms_condition_privacity = @accepted_term.acepted
         @user.save
        format.html { redirect_to root_path, notice: 'Accepted term was successfully created.' }
        format.json { render json: @accepted_term, status: :created, location: @accepted_term }
      else
        format.html { render action :back}
        format.json { render json: @accepted_term.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accepted_terms/1
  # PUT /accepted_terms/1.json
  def update
    @accepted_term = AcceptedTerm.find(params[:id])

    respond_to do |format|
      if @accepted_term.update_attributes(params[:accepted_term])
        format.html { redirect_to @accepted_term, notice: 'Accepted term was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @accepted_term.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accepted_terms/1
  # DELETE /accepted_terms/1.json
  def destroy
    @accepted_term = AcceptedTerm.find(params[:id])
    @accepted_term.destroy

    respond_to do |format|
      format.html { redirect_to accepted_terms_url }
      format.json { head :ok }
    end
  end
end
