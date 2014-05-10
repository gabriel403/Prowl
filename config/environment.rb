# Load the Rails application.
require File.expand_path('../application', __FILE__)

# set logger Rails.env.development

unless Rails.env.test
  if ENV['PROWL_LOGENTRIES_TOKEN']
    Rails.logger = Le.new(ENV['PROWL_LOGENTRIES_TOKEN'])
  else
    Rails.logger = Logger.new(STDOUT)
  end
end

# Initialize the Rails application.
Rails.application.initialize!
