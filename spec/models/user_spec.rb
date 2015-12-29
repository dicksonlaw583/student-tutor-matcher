require 'spec_helper'

describe User do

	describe "Attributes" do
		it { should respond_to :user_name }
		it { should respond_to :email }
		it { should respond_to :password }
		it { should respond_to :password_digest }
		it { should respond_to :role_id }
		it { should respond_to :first_name }
		it { should respond_to :last_name }
		it { should respond_to :address }
		it { should respond_to :phone }
		it { should respond_to :contact_method }
		it { should respond_to :program }
		it { should respond_to :year }
		it { should respond_to :cgpa }
		it { should respond_to :location_id }
		it { should respond_to :education_level }
		it { should respond_to :personal_description }
	end

	describe "Associations" do
		it { should respond_to :role }
		it { should respond_to :location }
		it { should respond_to :given_ratings }
		it { should respond_to :received_ratings }
		it { should respond_to :liking_students }
		it { should respond_to :favourite_tutors }
		it { should respond_to :outgoing_favourites }
		it { should respond_to :incoming_favourites }
		it { should respond_to :received_messages }
	end

	describe "Validations" do
	end

	describe "Offer a course" do
		before do
			@user = FactoryGirl.create(:tutor)
			@course = FactoryGirl.create(:course)
			@offering = @user.offer_course(@course, 23.50)
		end

		it "should offer a new course" do
			@user.courses.should include @course
		end

		it "should include a price with the offering" do
			@offering.price.should eq 23.50
		end
	end

	describe "Stop offering a course" do
		before do
			@user = FactoryGirl.create(:tutor)
			@course = FactoryGirl.create(:course)
			@offering = @user.offer_course(@course, 23.50)
		end

		it "should stop the course" do
			@user.withdraw_course(@course)
			@user.courses.should_not include @course
		end

		it "should kill the course offering" do
			expect{@user.withdraw_course(@course)}.to change{Offering.count}.by(-1)
		end
	end

	describe "Ratings" do
		before do
			@user = FactoryGirl.create(:user)
			@tutor = FactoryGirl.create(:tutor)
		end

		it "should be 0 for a fresh tutor" do
			@tutor.rating.should be 0
		end

		it "should update Tutor's rating" do
			@user.rate(@tutor, 3, "Decent but could be better")
			@tutor.rating.should be 3
		end

		it "should update Student's list of rated tutors" do
			@user.rate(@tutor, 3, "Decent but could be better")
			@user.rated_users.should include @tutor
		end

		it "should update Tutor's list of rating users" do
			@user.rate(@tutor, 3, "Decent but could be better")
			@tutor.rating_users.should include @user
		end
	end

	describe "Favourites" do
		before do
			@user = FactoryGirl.create(:user)
			@tutor = FactoryGirl.create(:tutor)
		end

		describe "Adding favourites" do
			before do
				@user.like(@tutor)
			end

			it "should add to Student's favourites" do
				@user.favourite_tutors.should == [@tutor]
			end

			it "should add to Tutor's list of liking students" do
				@tutor.liking_students.should == [@user]
			end
		end

		describe "Removing favourites" do
			before do
				@user.unlike(@tutor)
			end

			it "should remove from Student's favourites" do
				@user.favourite_tutors.should == []
			end

			it "should remove from Tutor's list of liking students" do
				@tutor.liking_students.should == []
			end
		end
	end

	describe "Role verification" do
		before do
			@student = FactoryGirl.create(:user)
			@tutor = FactoryGirl.create(:tutor)
			@admin = FactoryGirl.create(:admin)
		end

		it "should identify a student" do
			@student.is?(:student).should be_true
			@tutor.is?(:student).should be_false
			@admin.is?(:student).should be_false
		end

		it "should identify a tutor" do
			@student.is?(:tutor).should be_false
			@tutor.is?(:tutor).should be_true
			@admin.is?(:tutor).should be_false
		end

		it "should identify an admin" do
			@student.is?(:admin).should be_false
			@tutor.is?(:admin).should be_false
			@admin.is?(:admin).should be_true
		end
	end

	describe "Messages" do
		before do
			@sender = FactoryGirl.create(:user)
			@recipient = FactoryGirl.create(:tutor)
			@message = FactoryGirl.build(:message)
		end

		describe "Sending and receiving messages" do
			it "should increase number of messages by 1" do
				expect {
					@sender.send_message(@message, @recipient)
				}.to change(Message, :count).by(1)
			end

			it "should show up in the recipient's inbox" do
				@sender.send_message(@message, @recipient)
				@recipient.received_messages.should == [@message]
			end
		end

		describe "Deleting messages" do
			before :each do
				@sender.send_message(@message, @recipient)
			end

			it "should decrease number of messages by 1" do
				expect {
					@sender.delete_message(@message)
				}.to change(Message, :count).by(-1)
			end

			it "should no longer show up in the recipient's inbox" do
				@sender.delete_message(@message)
				@recipient.received_messages.should == []
			end
		end
	end

end
