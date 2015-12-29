require 'spec_helper'

describe "users/edit" do

  describe "Student Mode" do
    before(:each) do
      @user = FactoryGirl.build(:user)
      @user_type = @user.role
      @submit_path = users_path(@user)
      sign_in @user
    end

    it "renders edit user form" do
      render

      assert_select "form", :action => users_path(:type => "student"), :method => "post" do
        assert_select "input#user_user_name", :name => "user[user_name]"
        assert_select "input#user_password", :name => "user[password]"
        assert_select "input#user_first_name", :name => "user[first_name]"
        assert_select "input#user_last_name", :name => "user[last_name]"
        assert_select "input#user_email", :name => "user[email]"
        assert_select "input#user_address", :name => "user[address]"
        assert_select "input#user_phone", :name => "user[phone]"
        assert_select "input#user_program", :name => "user[program]"
        assert_select "input#user_contact_method", :name => "user[contact_method]"
        assert_select "input#user_year", :name => "user[year]"
      end
    end
  end

  describe "Tutor Mode" do
    before(:each) do
      @user = FactoryGirl.build(:tutor)
      @user_type = @user.role
      @submit_path = users_path
      sign_in @user
    end

    it "renders new user form" do
      render

      assert_select "form", :action => users_path(:type => "tutor"), :method => "post" do
        assert_select "input#user_user_name", :name => "user[user_name]"
        assert_select "input#user_password", :name => "user[password]"
        assert_select "input#user_first_name", :name => "user[first_name]"
        assert_select "input#user_last_name", :name => "user[last_name]"
        assert_select "input#user_email", :name => "user[email]"
        assert_select "input#user_address", :name => "user[address]"
        assert_select "input#user_phone", :name => "user[phone]"
        assert_select "select#user_location_id", :name => "user[location]"
        assert_select "input#user_cgpa", :name => "user[cgpa]"
        assert_select "input#user_education_level", :name => "user[education_level]"
        assert_select "input#user_contact_method", :name => "user[contact_method]"
        assert_select "textarea#user_personal_description", :name => "user[personal_description]"
      end
    end
  end
end
