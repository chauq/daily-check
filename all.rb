require 'capybara'
require 'rubygems'
require './arabic'
require './bbcwn'
require './channel_checker'

puts "Wecome to the daily checker, please input which browser you would like to test"
puts "Put ch for chrome, ff for firefox, ie for internet explorer, sa for safari"

web_browser = gets.chomp

puts "testing: " + web_browser

	if web_browser == "ch"
		driver = Selenium::WebDriver.for :chrome

		Capybara.register_driver :selenium do |app|
			Capybara::Selenium::Driver.new(app, browser: :chrome)
		end

		session = Capybara::Session.new(:selenium)

	elsif web_browser == "ff"
		driver = Selenium::WebDriver.for :firefox

		Capybara.register_driver :selenium do |app|
			Capybara::Selenium::Driver.new(app, browser: :firefox)
		end

		session = Capybara::Session.new(:selenium)	

	elsif web_browser == "ie"
		driver = Selenium::WebDriver.for :internet_explorer

		Capybara.register_driver :selenium do |app|
			Capybara::Selenium::Driver.new(app, browser: :internet_explorer)
		end

		session = Capybara::Session.new(:selenium)

	elsif web_browser == "sa"
		driver = Selenium::WebDriver.for :safari

		Capybara.register_driver :selenium do |app|
			Capybara::Selenium::Driver.new(app, browser: :safari)
		end

		session = Capybara::Session.new(:selenium)

	else
		puts "no browser found"
	end

bbcwn = Bbcwn.new(driver)
bbcwn.check

#arabic = Arabic.new(driver)
#arabic.check

#The list for the daily checks
chan = ["cnni", "cnbc", "bbc-world", "libyatv"]
site = ["http://www"]

#
#check both mobile and website
site.each do |site|
	chan.each do |chan|
		puts "Checking " + chan + " on " + site + ":"
		check = Checker.new(site, chan, session)
		check.channel
	end
end

exit(-1)

