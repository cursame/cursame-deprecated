class TutorialesController < ApplicationController
  # GET /tutoriales
  # GET /tutoriales.json
  def index
    @tutoriales = Tutoriale.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tutoriales }
    end
  end

  # GET /tutoriales/1
  # GET /tutoriales/1.json
  def show
    @tutoriale = Tutoriale.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tutoriale }
    end
  end

  # GET /tutoriales/new
  # GET /tutoriales/new.json
  def new
    @tutoriale = Tutoriale.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tutoriale }
    end
  end

  # GET /tutoriales/1/edit
  def edit
    @tutoriale = Tutoriale.find(params[:id])
  end

  # POST /tutoriales
  # POST /tutoriales.json
  def create
    @tutoriale = Tutoriale.new(params[:tutoriale])

    respond_to do |format|
      if @tutoriale.save
        format.html { redirect_to :back, notice: 'Tutorial agregado correctamente.' }
        format.json { render json: @tutoriale, status: :created, location: @tutoriale }
      else
        format.html { render action: "new" }
        format.json { render json: @tutoriale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tutoriales/1
  # PUT /tutoriales/1.json
  def update
    @tutoriale = Tutoriale.find(params[:id])

    respond_to do |format|
      if @tutoriale.update_attributes(params[:tutoriale])
        format.html { redirect_to @tutoriale, notice: 'Tutoriale was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @tutoriale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutoriales/1
  # DELETE /tutoriales/1.json
  def destroy
    @tutoriale = Tutoriale.find(params[:id])
    @tutoriale.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :ok }
    end
  end
end
