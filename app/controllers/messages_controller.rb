class MessagesController < ApplicationController
	before_filter :check_message_ownership, :only => [:read, :unread, :show, :destroy]

	def index
		@messages = current_user.received_messages.reject{|m| m.read}
	end

	def index_all
		@messages = current_user.received_messages
	end

	def show
		@message = Message.find_by_id(params[:id])
		@message.read = true
		@message.save
	end

	def new
		@message = Message.new
		@recipient = params[:recipient]
	end

	def read
		@message = Message.find(params[:id])
		@message.read = true
		@message.save
		respond_to do |format|
			format.html { redirect_to :back }
		end
	end

	def unread
		@message = Message.find(params[:id])
		@message.read = false
		@message.save
		respond_to do |format|
			format.html { redirect_to :back }
		end
	end

	def create
		@message = Message.new(params[:message])
	    
	    respond_to do |format|
	      if current_user.send_message(@message, User.find_by_user_name(params[:recipient]))
	        format.html { redirect_to messages_url, notice: "Message sent." }
	      else
	        format.html { render action: "new" }
	      end
	    end
	end

	def destroy
		@message = Message.find(params[:id])
	    current_user.delete_message(@message)

	    respond_to do |format|
	      format.html { redirect_to :back }
	    end
	end

	private

	def check_message_ownership
		@message = Message.find(params[:id])
		unless current_user.received_messages.include?(@message)
			@message = nil
			redirect_to messages_url
		end
	end

end
