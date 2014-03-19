require 'capybara'
require 'rubygems'
require "selenium-webdriver"
require './log_in'

class Check
	
	def initialize
		#This changes which browser the test will run, need to change the name of the browser after the browser:)
		Capybara.register_driver :selenium do |app|
			Capybara::Selenium::Driver.new(app, browser: :firefox)
		end
		
		@session = Capybara::Session.new(:selenium)
	end
	
	def screenshot (site, chan)
		if site == "http://www"
			@session.save_screenshot(chan + " www.png")
			puts "Screenshot of " + chan + " taken on " + site
		else
			@session.save_screenshot(chan + " m.png")
			puts "Screenshot of " + chan + " taken on " + site
		end
	end
	
	
	def channel (site, chan)
		#This opens the channel page
    	@session.visit site + ".livestation.com/en/channels/" + chan
		#Sign in in order to see the Premium channel
		log_in = Log_in.new(site, chan, @session)
		log_in.sign_in
		sleep 10
		#Check if the channel page is up by seeing if the word "Livestation" or "You May Like" is on the page
		if @session.has_content?("Livestation") || @session.has_content?("You May Like")
			puts "Working!"
			screenshot site, chan
			@session.reset!
			#@session.execute_script "window.close();"
		else
			puts "Something has gone wrong :'("
			@session.reset!
			#@session.execute_script "window.close();"
			return
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