class CommentPostsController < ApplicationController
  
  # POST /comment_posts
  # POST /comment_posts.json
  def create
    @comment_post = CommentPost.new(params[:comment_post])

    respond_to do |format|
      if @comment_post.save
        format.html { redirect_to blog_path, notice: 'Comment post was successfully created.' }
        format.json { render json: blog_path, status: :created, location: @comment_post }
      else
        format.html { render action: "new" }
        format.json { render json: blog_path, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comment_posts/1
  # PUT /comment_posts/1.json
  def update
    @comment_post = CommentPost.find(params[:id])

    respond_to do |format|
      if @comment_post.update_attributes(params[:comment_post])
        format.html { redirect_to @comment_post, notice: 'Comment post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comment_posts/1
  # DELETE /comment_posts/1.json
  def destroy
    @comment_post = CommentPost.find(params[:id])
    @comment_post.destroy

    respond_to do |format|
      format.html { redirect_to comment_posts_url }
      format.json { head :ok }
    end
  end
end
