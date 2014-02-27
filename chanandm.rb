require 'capybara'
require 'rubygems'
require 'win32/screenshot'

class Check
	
	def initialize
		@session = Capybara::Session.new(:selenium)
	end
	
	def sign_in (site, chan)
	#Will sign into the mobile or the main site since the text buttons are different 
		if site == "http://www"
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
			@session.visit site + ".livestation.com/en/channels/" + chan
		end
	end
	
	def screenshot (site, chan)
		if site == "http://www"
			Win32::Screenshot::Take.of(:foreground).write(chan + " www.png")
			puts "Screenshot of " + chan + " taken on " + site
		else
			Win32::Screenshot::Take.of(:foreground).write(chan + " m.png")
			puts "Screenshot of " + chan + " taken on " + site
		end
	end
	
	
	def channel (site, chan)
		#This opens the channel page
		@session.visit site + ".livestation.com/en/channels/" + chan
		#Sign in in order to see the Premium channel
		sign_in site, chan
		sleep 10
		#Check if the channel page is up by seeing if the word "Livestation" or "You May Like" is on the page
		if @session.has_content?("Livestation") || @session.has_content?("You May Like")
			puts "Working!"
			screenshot site, chan
			@session.reset!
		else
			puts "Something has gone wrong :("
			@session.reset!
		end 		
	end
	
end
	
#The list for the daily checks
chan = ["cnni", "cnbc", "bbc-world"]
site = ["http://m", "http://www"]

#check both mobile and website
site.each do |site|
	chan.each do |chan|
		puts "Checking " + chan + " on " + site + ":"
		Check.new.channel(site, chan)
	end
end
	
exit(-1)
exit(-1)
