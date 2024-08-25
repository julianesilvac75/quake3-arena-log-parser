class LogParser
  attr_reader :current_match

  def initialize(log_file_path)
    @log_file_path = log_file_path
    @current_match = 0
  end

  def parse
    logs = []
    File.foreach(@log_file_path) do |line|
      if line.include?("InitGame:")
        create_match
        logs << line
      else
        filtered_line = filter_log(line)
        if filtered_line
          logs << filtered_line
        end
      end
    end
    logs
  end

  def create_match
      new_match = Match.create
      @current_match = new_match.id

      new_match
  end

  private

  def filter_log(log)
    @logs_categories = [ "ClientUserinfoChanged:", "Kill:" ]

    @logs_categories.each do |category|
      if log.include?(category)
        return log
      end
    end

    nil
  end
end
