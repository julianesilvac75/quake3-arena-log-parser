class LogParser
  def initialize(log_file_path)
    @log_file_path = log_file_path
  end

  def parse
    logs = []
    File.foreach(@log_file_path) do |line|
      filtered_line = filter_log(line)
      if filtered_line
        logs << filtered_line
      end
    end

    logs
  end

  private

  def filter_log(log)
    @logs_categories = [ "InitGame:", "ClientUserinfoChanged:", "Kill:" ]

    @logs_categories.each do |category|
      if log.include?(category)
        return log
      end
    end

    nil
  end
end
