class NewUsersChangeTypesController < ApplicationController
  
  def create
    @new_users_change_type = NewUsersChangeType.new(params[:new_users_change_type])
    respond_to do |format|
      if @new_users_change_type.save
        
        @user = @new_users_change_type.user
        @user.new_old = @new_users_change_type.new_old
        @user.save
        
        format.html { redirect_to :back, notice: 'Se ha modificado el usuario .' }
        format.json { render json: @new_users_change_type, status: :created, location: @new_users_change_type }
      else
        format.html { render action: "new" }
        format.json { render json: @new_users_change_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @new_users_change_type = NewUsersChangeType.find(params[:id])

    respond_to do |format|
      if @new_users_change_type.update_attributes(params[:new_users_change_type])
        format.html { redirect_to @new_users_change_type, notice: 'New users change type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @new_users_change_type.errors, status: :unprocessable_entity }
      end
    end
  end

end
