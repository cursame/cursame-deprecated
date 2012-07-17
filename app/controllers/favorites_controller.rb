class FavoritesController < ApplicationController
 def new
    @favorite = Favorite.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @favorite }
    end
  end
  # GET /favorites/1/edit
  def edit
    @favorite = Favorite.find(params[:id])
  end
def create
    @favorite = Favorite.new(params[:favorite])

    respond_to do |format|
      if @favorite.save
        format.html { redirect_to :back, notice: 'El usuario se agrego correctamente a sus favoritos.' }
        format.json { render json: @favorite, status: :created, location: @favorite }
      else
        format.html { render action: "new" }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    if @favorite.destroy
        format.html { redirect_to :back, notice: 'El usuario fue retirado de sus favoritos.' }
    end
  end
  def my_favorite_users
    @user = current_user
    @favorite=@user.favorites
    @users_network = current_network.users.limit(200) if current_network
  end
private 
  # PUT /favorites/1
  # PUT /favorites/1.json
  def update
    @favorite = Favorite.find(params[:id])

    respond_to do |format|
      if @favorite.update_attributes(params[:favorite])
        format.html { redirect_to @favorite, notice: 'Favorite was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorites/1
  # DELETE /favorites/1.json
  
end
