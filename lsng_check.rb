require 'capybara'
require 'rubygems'
require './bbcwn.rb'
require "selenium-webdriver"

class Check
	
	def initialize
		#safari
		#This changes which browser the test will run, need to change the name of the browser after the "app, browser:" part")
		@driver = Selenium::WebDriver.for :chrome
	end	
	
	def channel (chan)
		#This opens the channel page
		@driver.get "http://livestation.com/"
		@driver.find_element(:id => "btn_intro_login").click 
		@driver.find_element(:id => "btn-modal-login-email").click 
    	@driver.get "http://livestation.com/" + chan + "/live"
    		if chan == "Alrayan"
    			@driver.get "http://www.alrayyan.tv/arabic/Pages/AlrayanLive.aspx"
    		end
		sleep 15
		@driver.save_screenshot("./all_lsng/" + chan + ".png")
		@driver.quit
	end	
	
end
	
chan = ["al_aan", "alalam", "al_jazeera", "al_jazeera_america", "al_jazeera_english", "al_jazeera_mubasher", 
	"al_jazeera_mubasher_misr", "almayadeen", "al_nabaa_tv", "bbc_arabic", "bbc_world", "bbc_persian", "bloomberg", 
	"cctv", "cnbc_emea", "cnc", "cnni", "dw_english", "dw_arabic", "enca", "espresotv", "euronews_english", 
	"euronews_arabic", "france24_arabic", "france24_english", "hispantv-spanish", "libyatv", "nabaa_tv", 
	"kurdsat", "press_tv", "reuters", "rt_english", "rt_arabic", "samaatv", "skynews_arabia", "voapersian", 
	"skynews_international", "i24news", "nabaa_tv", "Alrayan"]

chan.each do |chan|
	puts "Checking " + chan  + ":"
	Check.new.channel(chan)
end

Bbcwn.check()
	
exit(-1)