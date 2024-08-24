class LogParser
  def initialize(log_file_path)
    @log_file_path = log_file_path
  end

  def parse
    logs = []
    File.foreach(@log_file_path) do |line|
      logs << line
    end

    logs
  end
end
