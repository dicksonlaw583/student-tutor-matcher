require 'spec_helper'

describe Rating do

	describe "Attributes" do
		it { should respond_to :amount }
		it { should respond_to :comment }
		it { should respond_to :rating_user_id }
		it { should respond_to :rated_user_id }
	end

	describe "Associations" do
		it { should respond_to :rating_user }
		it { should respond_to :rated_user }
	end

end
