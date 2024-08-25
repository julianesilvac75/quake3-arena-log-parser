class LogImporter
  def initialize(log_file_path)
    @log_file_path = log_file_path
  end

  def self.find_file(file_path)
    @file = ImportLog.where(source_file: @log_file_path)

    if @file.present?
      @file.first
    else
      false
    end
  end

  def import
    imported_file = self.class.find_file(@log_file_path)

    if !imported_file
      result = ImportLog.create(source_file: @log_file_path, imported: true)
      "Log data was imported successfully. Source file: #{result.source_file}"
    else
      "Log data was already imported."
    end
  end
end
