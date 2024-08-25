class LogImporter
  def initialize(log_file_path)
    @log_file_path = log_file_path
  end
  def import
    true
  end

  def self.find_file(file_path)
    @file = ImportLog.where(source_file: @log_file_path)

    if @file.present?
      @file.first
    else
      false
    end
  end
end
