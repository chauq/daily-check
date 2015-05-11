require 'capybara'
require 'rubygems'
require "selenium-webdriver"

class Check
	
	def initialize
		#safari
		#This changes which browser the test will run, need to change the name of the browser after the "app, browser:" part")
		@driver = Selenium::WebDriver.for :chrome		
	end	
	
	def channel (site, chan)
		#This opens the channel page
    	@driver.get site + ".livestation.com/en/" + chan
    	if chan == "al_nabaa"
    		@driver.get site + ".livestation.com/#/station/al_nabaa_tv"
    	end
		sleep 30
		@driver.save_screenshot("./no sub/" + chan + ".png")
		@driver.quit
	end	
	
end
	
#The list for the daily checks
chan = ["al_nabaa"]
site = ["http://www"]

#"france24/ar", "france24/en", "rt/en", "rt/ar", "euronews/en", "euronews/ar",


site.each do |site|
	chan.each do |chan|
		puts "Checking " + chan + " on " + site + ":"
		Check.new.channel(site, chan)
	end
end
	
exit(-1)