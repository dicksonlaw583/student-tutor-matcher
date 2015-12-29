class RatingsController < ApplicationController

	def create
		params[:rating][:rating_user_id] = current_user.id
		@rating = Rating.new(params[:rating])

	    respond_to do |format|
	      if @rating.save
	        format.html { redirect_to :back, notice: 'Rating successfully added!' }
	        format.json { render json: @rating, status: :created, location: @rating }
	      else
	        format.html { redirect_to :back, error: 'Rating failed!' }
	        format.json { render json: @rating.errors, status: :unprocessable_entity }
	      end
	    end
	end

end
