class Log_in
	def initialize(site, chan, session)
		@site, @chan, @session = site, chan, session
	end

	def sign_in
	#Will sign into the mobile or the main site since the text buttons are different 
		if @site == "http://www"
			@session.click_on("Sign in or register")
			@session.fill_in("Email", {:with =>"test@streams.com"})
			@session.fill_in("Password", {:with =>"cologi37"})
			@session.click_on("Login")
		else
			@session.click_on("Sign in")
			@session.fill_in("Email", {:with =>"test@streams.com"})
			@session.fill_in("Password", {:with =>"cologi37"})
			@session.click_on("Log in")
			#Have to go back to the channel site on mobile, since it take you back to the channel list page
			@session.visit @site + ".livestation.com/en/channels/" + @chan
		end
	end
end