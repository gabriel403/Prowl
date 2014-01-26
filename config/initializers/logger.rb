# you probably want to overrite this with your own log configuration

if ENV['LOGGER_KEY']
  Rails.logger = Le.new(ENV['LOGGER_KEY'])
end