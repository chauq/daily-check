require 'capybara'
require 'rubygems'
require 'selenium-webdriver'

class Arabic

	def initialize(driver)
		@driver = driver
	end

	def check

		@driver.get "http://www.alrayyan.tv/arabic/Pages/AlrayanLive.aspx"
		sleep 5
		@driver.save_screenshot("./image/Alrayan.png")

		@driver.get "http://tv.kuwait.tt/"

		@driver.find_element(:id => "image31").click
		sleep 5
		@driver.save_screenshot("./image/Alwan2.png")

		@driver.find_element(:id => "image32").click
		sleep 5
		@driver.save_screenshot("./image/Alwanplus.png")

		@driver.find_element(:id => "image30").click
		sleep 5
		@driver.save_screenshot("./image/Alwan.png")

		@driver.quit
	end

end

