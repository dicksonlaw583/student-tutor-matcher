class Course < ActiveRecord::Base
	attr_accessible :name, :course_code, :description, :professor_name
	has_many :offerings
	has_many :users, :through => :offerings
end
