require 'capybara'
require 'rubygems'
require "selenium-webdriver"
require './log_in'
require './record'

class Check
	
	def initialize
		#This changes which browser the test will run, need to change the name of the browser after the "app, browser:" part")
		Capybara.register_driver :selenium do |app|
			Capybara::Selenium::Driver.new(app, browser: :firefox)
		end
		
		@session = Capybara::Session.new(:selenium)
	end	
	
	def channel (site, chan)
		#This opens the channel page
    	@session.visit site + ".livestation.com/en/channels/" + chan
		#Sign in in order to see the Premium channel
		if @session.has_content?("Sign in")
			log_in = Log_in.new(site, chan, @session)
			log_in.sign_in
		end
		sleep 10
		#Check if the channel page is up by seeing if the word "Livestation" or "You May Like" is on the page
		if @session.has_content?("Livestation") || @session.has_content?("You May Like")
			puts "Working!"
		else
			puts "Something has gone wrong :'("
			return
		end
		record = Record.new(site, chan, @session)
		record.screenshot
		@session.reset!
		#@session.execute_script "window.close();"
	end	
end
	
#The list for the daily checks
chan = ["cnni", "cnbc", "bbc-world"]
site = ["http://m", "http://www"]

#check both mobile and website
site.each do |site|
	chan.each do |chan|
		puts "Checking " + chan + " on " + site + ":"
		Check.new.channel(chan, site)
	end
end
	
exit(-1)