class User < ActiveRecord::Base
	attr_accessible :user_name, :email, :password, :password_digest, :role_id,
					:first_name, :last_name, :address, :phone, :contact_method,
					:program, :year, #Students
					:cgpa, :location_id, :education_level, :personal_description #Tutors
	has_secure_password
	before_create :create_remember_token

	belongs_to :role
	has_many :received_messages, :class_name => 'Message', :foreign_key => :recipient_id, :order => 'created_at DESC'

	#Tutor-specific associations
	has_many :offerings
	has_many :courses, :through => :offerings
	belongs_to :location

	has_many :received_ratings, :class_name => 'Rating', :foreign_key => :rated_user_id
	has_many :rating_users, :through => :received_ratings, :source => :rating_user
	
	has_many :incoming_favourites, :class_name => 'Favourite', :foreign_key => :favourite_tutor_id
	has_many :liking_students, :through => :incoming_favourites, :source => :liking_student


	#Student-specific associations
	# has_and_belongs_to_many :tutors
	has_many :given_ratings, :class_name => 'Rating', :foreign_key => :rating_user_id
	has_many :rated_users, :through => :given_ratings, :source => :rated_user

	has_many :outgoing_favourites, :class_name => 'Favourite', :foreign_key => :liking_student_id
	has_many :favourite_tutors, :through => :outgoing_favourites, :source => :favourite_tutor

	def offer_course(course, price)
		Offering.create(:user_id => self.id, :course_id => course.id, :price => price)
	end

	def withdraw_course(course)
		self.offerings.find_by_course_id(course.id).destroy
	end

	def rate(tutor, rating, comment)
		Rating.create(:rating_user_id => self.id, :rated_user_id => tutor.id, :amount => rating, :comment => comment)
	end

	def rating
		(self.received_ratings.blank?) ? 0 : (self.received_ratings.sum{|r| r.amount} / self.received_ratings.count)
	end

	def like(tutor)
		self.favourite_tutors << tutor
	end

	def unlike(tutor)
		self.favourite_tutors.delete(tutor)
	end

	def is?(role_name)
		self.role.name == "#{role_name}"
	end

	def send_message(message, recipient)
		message.sender = self
		message.recipient = recipient
		message.save
	end

	def delete_message(message)
		self.received_messages.delete(message)
		message.destroy
	end

	def unread_messages
		self.received_messages.reject { |m| m.read }
	end

	private

	def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64
	end
end
