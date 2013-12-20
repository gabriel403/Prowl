require 'logglier' 
Rails.application.config.logger = Logglier.new("https://logs-01.loggly.com/inputs/bd5fce10-4fba-4433-8b89-ebe68a5c270e/tag/ruby/")
