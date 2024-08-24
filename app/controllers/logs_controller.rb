class LogsController < ApplicationController
  def parse
    log_file_path = File.join("lib", "assets", "qgames.log")
    log_parser = LogParser.new(log_file_path)
    # puts log_parser
    @logs = log_parser.parse
  end
end
