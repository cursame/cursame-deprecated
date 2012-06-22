class BlogsController < ApplicationController
  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blogs }
    end
  end
  
  # POST /blogs
  # POST /blogs.json
   
  def create
    @blog = Blog.new(params[:blog])
    
    respond_to do |format|
      if @blog.save
        format.html { redirect_to :blog, notice: 'Blog was successfully created.' }
        format.json { render json: :blog, status: :created, location: @blog }
      else
        format.html { redirect_to :blog, notice: 'El post no fue creado satisfactoriamente' }
        format.json { render json: :blog, status: :created, location: @blog }
      end
    end
  end

  # PUT /blogs/1
  # PUT /blogs/1.json
  def update
    @blog = Blog.find(params[:id])

    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blogs_url }
      format.json { head :ok }
    end
  end
end
