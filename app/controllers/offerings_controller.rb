class OfferingsController < ApplicationController

	def index
		@offerings = Offering.find_all_by_user_id(current_user.id)
		@courses = Course.all.reject { |c| current_user.courses.include?(c) }
		respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @offerings }
	    end
	end

	def new
		@offering = Offering.new
		@courses = Course.all.reject { |c| current_user.courses.include?(c) }

		respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @offering }
	    end
	end

	def create
		params[:offering][:user_id] = current_user.id
		@offering = Offering.new(params[:offering])

		respond_to do |format|
	      if @offering.save
	        format.html { redirect_to offerings_path, notice: 'Offering was successfully created.' }
	        format.json { render json: @offering, status: :created, location: @offering }
	      else
	      	@courses = Course.all.reject { |c| current_user.courses.include?(c) }
	        format.html { render action: "new" }
	        format.json { render json: @offering.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def edit
		@offering = Offering.find_by_id(params[:id])
	end

	def update
		@offering = Offering.find(params[:id])
		params[:offering][:user_id] = current_user.id

	    respond_to do |format|
	      if @offering.update_attributes(params[:offering])
	        format.html { redirect_to offerings_path, notice: 'Offering was successfully updated.' }
	        format.json { head :no_content }
	      else
	        format.html { render action: "edit" }
	        format.json { render json: @offering.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def destroy
	    @offering = Offering.find(params[:id])
	    @offering.destroy

	    respond_to do |format|
	      format.html { redirect_to offerings_path }
	      format.json { head :no_content }
	    end
	end

end
