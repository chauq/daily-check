require 'capybara'
require 'rubygems'
require "selenium-webdriver"
require './log_in'
require './record'

class Checker
	
	def initialize(site, chan, session)
		@site, @chan, @session = site, chan, session
	end
	
	def channel
		#This opens the channel page
    	@session.visit @site + ".livestation.com/en/channels/" + @chan
		#Sign in in order to see the Premium channel
		if @session.has_content?("Sign in")
			log_in = Log_in.new(@site, @chan, @session)
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
		record = Record.new(@site, @chan, @session)
		record.screenshot
		@session.reset!
		#@session.execute_script "window.close();"
	end	
end