class Record
	def initialize(site, chan, session)
		@site, @chan, @session = site, chan, session
	end

	def screenshot
		if @site == "http://www"
			@session.save_screenshot(@chan + " www.png")
			puts "Screenshot of " + @chan + " taken on " + @site
		else
			@session.save_screenshot(@chan + " m.png")
			puts "Screenshot of " + @chan + " taken on " + @site
		end
	end
end