require 'logger'
require 'forwardable'

class Log
  class << self
    extend Forwardable
    def_delegators :logger, :debug, :info, :warn, :error, :fatal

    private

    def logger
      @logger ||= Logger.new(STDOUT)
    end
  end
end
