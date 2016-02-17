helpers do

	def current_user
		if session["email"]
			@current_user ||= User.find_by(email: session["email"])
		end
	end

	def logged_in?
		!current_user.nil?
	end
end