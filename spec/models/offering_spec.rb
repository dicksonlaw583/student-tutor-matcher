require 'spec_helper'

describe Offering do
  
	describe "Attributes" do
		it { should respond_to :price }
	end

	describe "Associations" do
		it { should respond_to :course }
		it { should respond_to :user }
	end

end
