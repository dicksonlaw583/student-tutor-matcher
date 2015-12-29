require 'spec_helper'

describe FavouritesController do

	before do
		@user = FactoryGirl.create(:user)
		@tutor = FactoryGirl.create(:tutor)
		@tutor2 = FactoryGirl.create(:tutor)
		@user.like(@tutor)
		sign_in @user
	end

	describe "GET index" do
		it "Lists user's favourite tutors" do
			get :index
			assigns(:favourite_tutors).should == [@tutor]
		end
	end

	describe "POST create" do
		it "Adds to user's favourite tutors" do
			expect {
				post :create, { :tutor_id => @tutor2.id }
			}.to change{@user.favourite_tutors.count}.by(1)
		end

		it "Redirects back to index for HTML" do
			post :create, {:tutor_id => @tutor2.id, :format => "html" }
			response.should redirect_to(favourites_url)
		end

		it "Does not redirect for AJAX" do
			post :create, {:tutor_id => @tutor2.id, :format => "js" }
			response.should_not redirect_to(favourites_url)
			response.should render_template("create")
		end
	end

	describe "DELETE destroy" do
		before do
			@user.like(@tutor2)
		end

		it "Removes the correct tutor from the user's favourites" do
			expect {
				delete :destroy, { :tutor_id => @tutor.id }
			}.to change{@user.favourite_tutors.count}.by(-1)
		end

		it "Redirects back to index for HTML" do
			delete :destroy, { :tutor_id => @tutor.id, :format => "html" }
			response.should redirect_to(favourites_url)
		end

		it "Does not redirect for AJAX" do
			delete :destroy, { :tutor_id => @tutor.id, :format => "js" }
			response.should_not redirect_to(favourites_url)
			response.should render_template("destroy")
		end
	end

end
