require "selenium-webdriver"

class Bbcwn

	def initialize(driver)
		@driver = driver
	end

	def check

		@driver.navigate.to "http://BBCWorldNews:GlobalNewsLtd@bbcworldnews.livestation.com/"
		puts @driver.current_url

		sleep 15
		@driver.save_screenshot("./all_lsng/bbcwn.png")

		@driver.quit

	end
end