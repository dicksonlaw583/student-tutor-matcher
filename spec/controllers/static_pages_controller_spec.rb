require 'spec_helper'

describe StaticPagesController do

	describe "GET home" do

		describe "As unauthenticated user" do
			it "should render the homepage" do
				get :home
				response.should render_template("home")
			end
		end

		describe "As authenticated user" do
			before do
				@user = FactoryGirl.create(:user)
				sign_in @user
			end

			it "should redirect to the profile" do
				get :home
				response.should redirect_to(@user)
			end
		end

	end

end
