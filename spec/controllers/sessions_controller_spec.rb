require 'spec_helper'

describe SessionsController do

	describe "GET new" do
		it "should render the login form" do
			get :new
			response.should render_template("new")
		end
	end

	describe "POST create" do
		before :each do
			@user = FactoryGirl.create(:user)
		end

		it "should let good user in" do
			post :create, {:session => {:user_name => "username", :password => "password"}}
		end

		it "should keep wrong user name out" do
			post :create, {:session => {:user_name => "bad", :password => "password"}}
		end

		it "should keep wrong password out" do
			post :create, {:session => {:user_name => "username", :password => "bad"}}
		end
	end

	describe "DELETE destroy" do
		before :each do
			@user = FactoryGirl.create(:user)
			sign_in @user
		end

		it "should redirect to root" do
			delete :destroy
			response.should redirect_to(root_url)
		end
	end

end
