class SearchController < ApplicationController
	before_filter :persist_entries

	def index
	end

	def query
		@offers = Offering.all
		unless params[:course].blank?
			@offers = @offers.select { |o| o.course.course_code == params[:course] }
		end
		unless params[:price].blank?
			@offers = @offers.select { |o| o.price < params[:price].to_d }
		end
		unless params[:professor_name].blank?
			@offers = @offers.select { |o| o.course.professor_name == params[:professor_name] }
		end
		unless params[:location_id].blank?
			@offers = @offers.select { |o| o.user.location_id == params[:location_id].to_i }
		end
	end

	private

	def persist_entries
		@form = params
	end

end
