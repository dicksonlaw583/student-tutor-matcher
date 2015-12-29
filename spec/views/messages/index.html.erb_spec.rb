require 'spec_helper'

describe "messages/index" do
  before :each do
    @recipient = FactoryGirl.create(:tutor)
    sign_in @recipient
  end

  describe "Blank inbox" do
    before do
      assign(:messages, [])
    end

    it "renders no messages message" do
      render
      assert_select "p", :text => "You have no unread messages."
    end
  end

  describe "Filled inbox" do
    before do
      @sender = FactoryGirl.create(:user, { :user_name => "Waahoo" })
      @message1 = FactoryGirl.build(:message, { :subject => "Subject 1" })
      @message2 = FactoryGirl.build(:message, { :subject => "Subject 2" })
      @sender.send_message(@message1, @recipient)
      @sender.send_message(@message2, @recipient)
      assign(:messages, [@message2, @message1])
    end

    it "renders a list of messages" do
      render
      # Run the generator again with the --webrat flag if you want to use webrat matchers
      expect(rendered).to match /My Inbox/
      expect(rendered).to match /From/
      expect(rendered).to match /Subject/
      expect(rendered).to match /Received on/
      expect(rendered).to match /#{@sender.user_name}/
      expect(rendered).to match /#{@message1.subject}/
      expect(rendered).to match /#{@message2.subject}/
    end
  end

end
