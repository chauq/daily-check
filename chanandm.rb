require 'capybara'
require 'rubygems'
require 'win32/screenshot'

class Check
	
	def initialize
		@session = Capybara::Session.new(:selenium)
	end
	
	def sign_in (site, chan)
		if site == "http://www."
			@session.click_on("Sign in or register")
			@session.fill_in("Email", {:with =>"test@streams.com"})
			@session.fill_in("Password", {:with =>"cologi37"})
			@session.click_on("Login")
		else
			@session.click_on("Sign in")
			@session.fill_in("Email", {:with =>"test@streams.com"})
			@session.fill_in("Password", {:with =>"cologi37"})
			@session.click_on("Log in")
			@session.visit site + "livestation.com/en/channels/" + chan
		end
	end
	
	
	def channel (site, chan)
		#This opens the channel page
		@session.visit site + "livestation.com/en/channels/" + chan
		#Sign in in order to see the Premium channel
		sign_in site, chan
		#Check if the channel page is up by seeing if the word "Livestation" is on the page
		find('#navigation').should have_button('Sign out')
		if @session.has_content?("Livestation")
			puts "Working!"
			sleep 10
			Win32::Screenshot::Take.of(:foreground).write(chan + ".png")
			puts "Screenshot of " + chan + " taken"
			@session.reset!
		else
			puts "Something has gone wrong :("
			@session.reset!
		end 		
	end
	
end
	
#The list for the daily checks
chan = ["cnni", "cnbc", "bbc-world"]
site = ["http://m.", "http://www."]

site.each do |site|
	chan.each do |chan|
		puts "Checking " + chan + " on " + site + ":"
		Check.new.channel(site, chan)
	end
end
	
exit(-1)
