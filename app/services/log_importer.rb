class LogImporter
  def initialize(log_file_path)
    @log_file_path = log_file_path.to_s
  end

  def find_file
    file = ImportLog.where(source_file: @log_file_path)

    if file.present?
      file.first
    else
      false
    end
  end

  def import
    file = find_file

    return if file

    new_file = ImportLog.create(source_file: @log_file_path)

    logs = LogParser.new(@log_file_path)
    logs.parse

    new_file.update_attribute(:imported, true)
  end
end
