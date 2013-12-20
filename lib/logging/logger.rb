module Logging
  # This is the magical bit that gets mixed into your classes
  require 'syslog/logger'
  def logger
    Logging.logger
  end

  # Global, memoized, lazy initialized instance of a logger
  def self.logger
    @logger ||= Syslog::Logger.new 'my_program'
  end
end