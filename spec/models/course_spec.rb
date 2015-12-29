require 'spec_helper'

describe Course do

	describe "Attributes" do
		it { should respond_to :name }
		it { should respond_to :course_code }
		it { should respond_to :description }
		it { should respond_to :professor_name }
	end

	describe "Associations" do
		it { should respond_to :offerings }
		it { should respond_to :users }
	end

end
