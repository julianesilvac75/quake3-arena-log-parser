class LogsController < ApplicationController
  def initialize
    @matches = Match.all
  end

  def parse
    log_file_path = File.join("lib", "assets", "qgames.log")
    log_parser = LogParser.new(log_file_path)
    @logs = log_parser.parse
    @matches
  end
end
