class LikeNotLikesController < ApplicationController
  # GET /like_not_likes
  # GET /like_not_likes.json
  def index
    @like_not_likes = LikeNotLike.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @like_not_likes }
    end
  end

  # GET /like_not_likes/1
  # GET /like_not_likes/1.json
  def show
    @like_not_like = LikeNotLike.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @like_not_like }
    end
  end

  # GET /like_not_likes/new
  # GET /like_not_likes/new.json
  def new
    @like_not_like = LikeNotLike.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @like_not_like }
    end
  end

  # GET /like_not_likes/1/edit
  def edit
    @like_not_like = LikeNotLike.find(params[:id])
  end

  # POST /like_not_likes
  # POST /like_not_likes.json
  def create
    @like_not_like = LikeNotLike.new(params[:like_not_like])
  
    respond_to do |format|
      if @like_not_like.save
        format.html { redirect_to :back, notice: 'Like not like was successfully created.' }
        format.json { render json: @like_not_like, status: :created, location: @like_not_like }
        @comment = @like_not_like.comment
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @like_not_like.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /like_not_likes/1
  # PUT /like_not_likes/1.json
  def update
    @like_not_like = LikeNotLike.find(params[:id])

    respond_to do |format|
      if @like_not_like.update_attributes(params[:like_not_like])
        format.html { redirect_to @like_not_like, notice: 'Like not like was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @like_not_like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /like_not_likes/1
  # DELETE /like_not_likes/1.json
  def destroy
    @like_not_like = LikeNotLike.find(params[:id])
    @like_not_like.destroy

    respond_to do |format|
      format.html { redirect_to like_not_likes_url }
      format.json { head :ok }
    end
  end
end
