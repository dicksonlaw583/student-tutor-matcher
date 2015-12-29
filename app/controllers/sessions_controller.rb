class SessionsController < ApplicationController

	def new
		render :new
	end

	def create
		user = User.find_by_user_name(params[:session][:user_name])
		if user && user.authenticate(params[:session][:password])
			sign_in user
			flash.now[:notice] = "You are now signed in."
			redirect_to user
		else
			flash.now[:error] = "Incorrect user name and/or password."
			render :new
		end
	end

	def destroy
		sign_out
    	redirect_to root_url
	end

end
