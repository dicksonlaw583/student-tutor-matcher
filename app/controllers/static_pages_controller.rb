class StaticPagesController < ApplicationController
	before_filter :redirect_home, :only => [:home]

	def home
	end
	
	private

	def redirect_home
		if signed_in?
			redirect_to current_user	
		end
	end

end
