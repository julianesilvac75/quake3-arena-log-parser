Rails.application.config.after_initialize do
  @log_file_path = Rails.root.join("lib", "assets", "qgames.log")

  log_importer = LogImporter.new(@log_file_path)
  log_importer.import
end
