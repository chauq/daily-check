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
    	#The old site used /en /ar to pick which channel it went to "france24/ar", "france24/en", "rt/en", "rt/ar", "euronews/en", "euronews/ar",
    	#rename chan since / can't be used in the screenshot filename
    		if chan == "euronews/en"
    			chan = 'euronews_english'
    			@driver.get "http://livestation.com/euronews_english/live"
    		elsif chan == "euronews/ar"
    			chan = 'euronews_arabic'
    			@driver.get "http://livestation.com/euronews_arabic/live"
    		elsif chan == "france24/ar"
    			chan = 'france24_arabic'
    			@driver.get "http://livestation.com/france24_arabic/live"
    		elsif chan == "france24/en"
    			chan = 'france24_english'
    			@driver.get "http://livestation.com/france24_english/live"
    		elsif chan == "rt/en"
    			chan = 'rt_english'
    			@driver.get "http://livestation.com/rt_english/live"
    		elsif chan == "rt/ar"
    			chan = 'rt_arabic'
    			@driver.get "http://livestation.com/rt_arabic/live"
    		elsif chan == "al_nabaa"
    			@driver.get "http://livestation.com/al_nabaa_tv/live"
    		elsif chan == "Alrayan"
    			@driver.get "http://www.alrayyan.tv/arabic/Pages/AlrayanLive.aspx"
    		end
		sleep 10
		@driver.save_screenshot("./no sub/" + chan + ".png")
		@driver.quit
	end	
	
end
	
#The old list for the daily checks
=begin
chan = ["al-aan", "alalam", "aljazeera-arabic", "aljazeera-america", "aljazeera-english", "aljazeera-mubasher", 
	"aljazeera-mubasher-misr", "almayadeen", "al_nabaa", "bbc-arabic", "bbc-news", "bbc-world", "bbc-parliament", 
	"bbc-world-service", "bbc-persian", "bloomberg", "c-span", "cctv", "cnbc", "cnc", "cnni", "dw", "dw-arabia", 
	"enca", "espresotv", "euronews/en", "euronews/ar", "france24/ar", "france24/en", "foxradio-en", "hispantv-spanish", "libyatv", "nabaa_tv", 
	"nasa-tv", "ndtv", "kurdsat", "press-tv", "reuters", "rt/en", "rt/ar", "samaatv", "sky-news-arabia", "voapersian", "cna", "sky-news-international", 
	"i24news", "nabaa_tv", "al_nabaa", "Alrayan"]
=end
chan = ["al-aan", "alalam", "aljazeera-arabic", "aljazeera-america", "aljazeera-english", "aljazeera-mubasher", 
	"aljazeera-mubasher-misr", "almayadeen", "al_nabaa", "bbc-arabic", "bbc-world", "bbc-persian", "bloomberg", 
	"cctv", "cnbc", "cnc", "cnni", "dw", "dw-arabia", "enca", "espresotv", "euronews/en", "euronews/ar", 
	"france24/ar", "france24/en", "hispantv-spanish", "libyatv", "nabaa_tv", "kurdsat", "press-tv", "reuters", 
	"rt/en", "rt/ar", "samaatv", "sky-news-arabia", "voapersian", "cna", "sky-news-international", 
	"i24news", "nabaa_tv", "al_nabaa", "Alrayan"]
site = ["http://www"]

site.each do |site|
	chan.each do |chan|
		puts "Checking " + chan + " on " + site + ":"
		Check.new.channel(site, chan)
	end
end
	
exit(-1)