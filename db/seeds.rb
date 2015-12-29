# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

admin_name = "admin"
admin_password = "password"
admin_email = "admin@admin.com"

#Generate roles
["student", "tutor", "admin"].each do |role|
	Role.find_or_create_by_name(role)
end

#Generate locations
["St. George", "UTM", "UTSC"].each do |location|
	Location.find_or_create_by_name(location)
end

#Generate users
a = User.create!(
	:user_name => admin_name,
	:password => admin_password, 
	:email => admin_email, 
	:role_id => Role.find_by_name("admin").id
	)
t1 = User.create!(
	:user_name => "testtutor1", 
	:password => "password", 
	:email => "tutor1@tutor.com", 
	:role_id => Role.find_by_name("tutor").id,
	:location_id => Location.find_by_name("UTM").id
	)
t2 = User.create!(
	:user_name => "testtutor2", 
	:password => "password", 
	:email => "tutor2@tutor.com", 
	:role_id => Role.find_by_name("tutor").id,
	:location_id => Location.find_by_name("UTSC").id
	)
s = User.create!(
	:user_name => "teststudent", 
	:password => "password", 
	:email => "student@student.com", 
	:role_id => Role.find_by_name("student").id
	)

#Generate courses
c1 = Course.create!(
	:course_code => "CSCC01", 
	:name => "Intro to Software Engineering", 
	:professor_name => "E. Esfahani", 
	:description => "Lorem ipsum dolor"
	)
c2 = Course.create!(
	:course_code => "CSCC69", 
	:name => "Operating Systems", 
	:professor_name => "B. Schroeder", 
	:description => "Lorem ipsum dolor"
	)

#Tutor 1 offers CSCC01 and is at UTM
t1.offer_course(c1, 25)

#Tutor 2 offers CSCC01 and CSCC69 and is at UTSC
t2.offer_course(c1, 17)
t2.offer_course(c2, 20)