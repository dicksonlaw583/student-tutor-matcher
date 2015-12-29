require 'spec_helper'

describe SearchController do

	def valid_attributes
	    {
			:name => "Test course",
			:course_code => "TSTA01",
			:description => "A waahoo test course",
			:professor_name => "E. Test"
	    }
  	end

end
