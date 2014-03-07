require 'capybara'
require 'rubygems'

class Check
	
	def initialize
		@session = Capybara::Session.new(:selenium)
	end
	
	def sign_in
		@session.click_on("Sign in or register")
		@session.fill_in("Email", {:with =>"test....,"})
		@session.fill_in("Password", {:with =>"......"})
		@session.click_on("Login")
	end


	def channel chan
		#This opens the channel page
		@session.visit "http://www.livestation.com/en/channels/" + chan
		#Sign in in order to see the Premium channel
		sign_in
		#Check if the channel page is up by seeing if the word "About Livestation" is on the page
		if @session.has_content?("About Livestation")
			puts "Working!"
			sleep 10
			@session.save_screenshot(chan + ".png")
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

chan.each do |chan|
	puts "Checking " + chan + ":"
	Check.new.channel(chan)
end

exit(-1)
