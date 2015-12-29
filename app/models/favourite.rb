class Favourite < ActiveRecord::Base
	attr_accessible :favourite_tutor_id, :liking_student_id
	belongs_to :favourite_tutor, :class_name => 'User', :foreign_key => 'favourite_tutor_id'
	belongs_to :liking_student, :class_name => 'User', :foreign_key => 'liking_student_id'
end
