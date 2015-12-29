FactoryGirl.define do

	factory :user do
		user_name		"dummystudent"
		password		"password"
		role			Role.find_or_create_by_name("student")
	end

	factory :tutor, :class => User do
		user_name		"dummytutor"
		password		"password"
		role			Role.find_or_create_by_name("tutor")
	end

	factory :admin, :class => User do
		user_name		"dummyadmin"
		password		"password"
		role			Role.find_or_create_by_name("admin")
	end

end