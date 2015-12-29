class Offering < ActiveRecord::Base
	attr_accessible :price, :course_id, :user_id
	belongs_to :course
	belongs_to :user
end
