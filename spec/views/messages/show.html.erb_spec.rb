require 'spec_helper'

describe "messages/show" do
  before :each do
    @sender = FactoryGirl.create(:user, { :user_name => "Waahoo" })
    @recipient = FactoryGirl.create(:tutor)
    @message = FactoryGirl.build(:message, { :subject => "Test subject", :body => "This is a test message." })
    @sender.send_message(@message, @recipient)
    assign(:message, @message)
    sign_in @recipient
  end

  it "renders the message" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Reading message: Test subject/)
    rendered.should match(/Waahoo/)
    rendered.should match(/This is a test message./)
  end
end
