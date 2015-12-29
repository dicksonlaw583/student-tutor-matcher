class Message < ActiveRecord::Base
	attr_accessible :sender_id, :recipient_id, :subject, :body, :read

	belongs_to :sender, :class_name => 'User', :foreign_key => "sender_id"
	belongs_to :recipient, :class_name => 'User', :foreign_key => "recipient_id"

	validates_presence_of :sender
	validate :recipient_check
	validates :body, presence: true

	private

	def recipient_check
		if recipient.blank?
			errors.add("Recipient", "must be a valid user")
		end
	end
end
