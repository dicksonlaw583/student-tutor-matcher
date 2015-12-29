class FavouritesController < ApplicationController

	def index
		@favourite_tutors = current_user.favourite_tutors
		respond_to do |format|
			format.html
			format.json { render json: @favourite_tutors }
		end
	end

	def create
		@user = User.find_by_id(params[:tutor_id])
		current_user.like(@user)
		respond_to do |format|
			format.html { redirect_to favourites_url }
			format.js { render :create }
		end
	end

	def destroy
		@user = User.find_by_id(params[:tutor_id])
		current_user.unlike(@user)
		respond_to do |format|
			format.html { redirect_to favourites_url }
			format.js { render :destroy }
		end
	end

end
