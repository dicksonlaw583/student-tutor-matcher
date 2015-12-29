require 'spec_helper'

describe MessagesController do

	before :each do
		@sender = FactoryGirl.create(:user)
		@recipient = FactoryGirl.create(:user)
		@other_recipient = FactoryGirl.create(:user)
		@message_read = FactoryGirl.build(:message, { :read => true })
		@message_unread = FactoryGirl.build(:message)
		@message_unauthorized = FactoryGirl.build(:message)
		@sender.send_message(@message_read, @recipient)
		@sender.send_message(@message_unread, @recipient)
		@sender.send_message(@message_unauthorized, @other_recipient)
		sign_in @recipient
	end

	def valid_attributes
		{
			:subject => "Valid subject",
			:body => "Valid body"
		}
	end

	describe "GET index" do
		it "lists only new unread messages" do
			get :index
			assigns(:messages).should == [@message_unread]
		end
	end

	describe "GET index_all" do
		it "lists all messages in descending order of time sent" do
			get :index_all
			assigns(:messages).should == [@message_unread, @message_read]
		end
	end

	describe "GET show" do
		it "assigns requested message as @message" do
			get :show, {:id => @message_unread.to_param}
			assigns(:message).should eq(@message_unread)
		end

		it "marks @message as read" do
			get :show, {:id => @message_unread.to_param}
			assigns(:message).read.should be_true
		end

		it "denies access to other people's messages" do
			get :show, {:id => @message_unauthorized.to_param}
			assigns(:message).should_not eq(@message_unauthorized)
			response.should redirect_to(messages_url)
		end
	end

	describe "GET new" do
		it "creates a new message in construction" do
			get :new
			assigns(:message).should be_a_new(Message)
		end
	end

	describe "PUT read" do
		before do
			@message_unauthorized.read = false
			request.env["HTTP_REFERER"] = 'back'
		end

		it "marks unread message as read" do
			put :read, {:id => @message_unread.id}
			assigns(:message).read.should be_true
		end

		it "denies access to other people's messages" do
			put :read, {:id => @message_unauthorized.id}
			@message_unauthorized.read.should_not be_true
		end

		it "should redirect back" do
			put :read, {:id => @message_unread.id}
			response.should redirect_to('back')
		end
	end

	describe "PUT unread" do
		before do
			@message_unauthorized.read = true
			request.env["HTTP_REFERER"] = 'back'
		end

		it "marks read message as unread" do
			put :unread, {:id => @message_read.id}
			assigns(:message).read.should be_false
		end

		it "denies access to other people's messages" do
			put :unread, {:id => @message_unauthorized.id}
			@message_unauthorized.read.should_not be_false
		end

		it "should redirect back" do
			put :unread, {:id => @message_read.id}
			response.should redirect_to('back')
		end
	end

	describe "POST create" do
		describe "with valid params" do
	      it "creates a new Message" do
	        expect {
	          post :create, {:message => valid_attributes, :recipient => @recipient.user_name }
	        }.to change(Message, :count).by(1)
	      end

	      it "assigns a newly created message as @message" do
	        post :create, {:message => valid_attributes, :recipient => @recipient.user_name }
	        assigns(:message).should be_a(Message)
	        assigns(:message).should be_persisted
	      end

	      it "redirects to inbox" do
	        post :create, {:message => valid_attributes, :recipient => @recipient.user_name }
	        response.should redirect_to(messages_url)
	      end
	    end

	    describe "with invalid params" do
	      it "assigns a newly created but unsaved message as @message" do
	        # Trigger the behavior that occurs when invalid params are submitted
	        Message.any_instance.stub(:save).and_return(false)
	        post :create, {:message => {}, :recipient => @recipient.user_name }
	        assigns(:message).should be_a_new(Message)
	      end

	      it "re-renders the 'new' template" do
	        # Trigger the behavior that occurs when invalid params are submitted
	        Message.any_instance.stub(:save).and_return(false)
	        post :create, {:message => {}, :recipient => @recipient.user_name }
	        response.should render_template("new")
	      end
	    end
	end

	describe "DELETE destroy" do
		before do
			request.env["HTTP_REFERER"] = 'back'
		end

		it "destroys message if belong to the user" do
			expect {
				delete :destroy, {:id => @message_read.to_param}
			}.to change(Message, :count).by(-1)
		end

		it "doesn't destroy a message belonging to somebody else" do
			expect {
				delete :destroy, {:id => @message_unauthorized.to_param}
			}.not_to change(Message, :count)
		end

		it "should redirect back" do
			delete :destroy, {:id => @message_read.to_param}
			response.should redirect_to('back')
		end
	end

end
