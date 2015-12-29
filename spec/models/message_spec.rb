require 'spec_helper'

describe Message do

	before do
		@sender = FactoryGirl.create(:user)
		@recipient = FactoryGirl.create(:tutor)
	end

	describe "Attributes" do
		it { should respond_to :sender_id }
		it { should respond_to :recipient_id }
		it { should respond_to :body }
		it { should respond_to :subject }
		it { should respond_to :read }
	end

	describe "Associations" do
		it { should respond_to :sender }
		it { should respond_to :recipient }
	end

	describe "Validations" do
		before :each do
			@message = FactoryGirl.create(:message, { :sender_id => @sender.id, :recipient_id => @recipient.id })
		end

		it "should not allow blank senders" do
			@message.sender = nil
			@message.should_not be_valid	
		end

		it "should not allow blank recipients" do
			@message.recipient = nil
			@message.should_not be_valid
		end

		it "should not allow blank bodies" do
			@message.body = ""
			@message.should_not be_valid
		end
	end

end
