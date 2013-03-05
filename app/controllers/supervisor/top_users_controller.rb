class Supervisor::TopUsersController < ApplicationController
	def index
		@users = User.all
		render json: @users.map(&:last_name)
	end
	def search_users
		@users = User.order(:last_name).where("((users.first_name || ' ' || users.last_name) #{LIKE} ?) OR
                   (users.first_name #{LIKE}  ?) OR (users.last_name #{LIKE} ?)",
                   "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%")
		render json: @users
	end
	def save_top_users
		#borramos todos los ranking
		Ranking.delete_all

		#si ya existe lista usuarios top
		if @top_user = TopUsers.last
			@tp_id = @top_user.id
		else
			TopUsers.create(:name => 'Expertos Top')
		end
		@user_ids = params[:top_users][:users]
		
		@user_ids.each_with_index do |id,idx|
			Ranking.create('user_id' => id,'top_users_id' => @tp_id ,'order' => idx) 
		end
		respond_to do |format|       
          format.js
      	end
	end
end
