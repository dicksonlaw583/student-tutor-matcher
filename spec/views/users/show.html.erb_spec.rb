require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, FactoryGirl.create(:user, 
      :user_name => "User Name",
      :email => "Email",
      :password => "Password",
    ))
    @user_type = @user.role
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/User Name/)
    rendered.should match(/Email/)
  end
end
