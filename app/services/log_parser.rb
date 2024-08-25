class LogParser
  attr_reader :current_match

  def initialize(log_file_path)
    @log_file_path = log_file_path
    @current_match = 0
  end

  def parse
    logs = filter_logs

    logs.each do |line|
      if line.include?("InitGame:")
        create_match
      elsif line.include?("ClientUserinfoChanged")
        "ClientUserinfoChanged"
      elsif line.include?("Kill:")
        "kill"
      end
    end

    logs
  end

  def create_match
      new_match = Match.create
      @current_match = new_match.id

      new_match
  end

  def filter_logs
    @logs_categories = [ "InitGame:", "ClientUserinfoChanged:", "Kill:" ]
    logs = []

    File.foreach(@log_file_path) do |line|
      @logs_categories.each do |category|
        if line.include?(category)
          logs << line
        end
      end
    end

    logs
  end
end
