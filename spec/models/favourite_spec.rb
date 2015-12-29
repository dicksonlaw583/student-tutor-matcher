require 'spec_helper'

describe Favourite do
  
	describe "Attributes" do
		it { should respond_to :favourite_tutor_id }
		it { should respond_to :liking_student_id }
	end

	describe "Associations" do
		it { should respond_to :favourite_tutor }
		it { should respond_to :liking_student }
	end

end
