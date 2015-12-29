class Tutor < ActiveRecord::Base

	validate :password_not_blank

	def password_not_blank
		if password.blank?
			errors.add(:tutor, "Password may not be blank")
		end
	end

end
