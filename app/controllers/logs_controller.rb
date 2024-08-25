class LogsController < ApplicationController
  def initialize
    @log_file_path = Rails.root.join("lib", "assets", "qgames.log")
  end
  def index
    log_parser = LogParser.new(@log_file_path)

    @logs = log_parser.filter_logs
  end
end
