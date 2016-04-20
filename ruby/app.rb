require "sinatra/base"

module App
  class Main < Sinatra::Base

    configure do
      enable :logging
      set :raise_errors, true
    end

    before do
      logger.datetime_format = "%Y/%m/%d @ %H:%M:%S "
      logger.level = Logger::INFO
    end

    get '/' do
      logger.debug "debug message"
      logger.info "info message"
      port = ENV['CF_INSTANCE_PORT']
      "\n<h1>Hello World from port #{port}!!</h1>\n"
    end

    get "/broken" do
      logger.debug "trying broken service"
      `ps -AF | grep -m1 "ruby" | awk '{print $2;}' | (read pid; kill -9 $pid)`
    end

    get "/systemcrash" do
      logger.debug "crashing the app"
      Kernel.exit!
    end
    run!
  end

end
