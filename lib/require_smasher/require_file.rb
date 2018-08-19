module RequireFile
  def self.require_files(files, attempt = 0)
    raise StandardError, 'File was not informed' if files.empty?
    errors_list = req_files(files)

    return if errors_list[:files_with_error].empty?
    attempt += 1 if files == errors_list[:files_with_error]

    raise StandardError, errors_list[:errors] if attempt > 1
    require_files(errors_list[:files_with_error], attempt)
  end

  def self.require_directories(directories)
    raise StandardError, 'Directory was not informed' if directories.empty?
    require_files(files(directories))
  end

  def self.files(directories)
    raise StandardError, 'Directory was not informed' if directories.empty?

    files = []
    directories.uniq.each do |directory|
      raise StandardError, "Directory '#{directory}' does not exist" unless Dir.exist?(directory)
      files.concat(Dir.glob(File.join(File.expand_path("./#{directory}"), '**', '*.rb')))
    end
    files
  end

  def self.req_files(files)
    errors_list = { files_with_error: [], errors: [] }

    files.uniq.each do |file|
      begin
        require_relative file
      rescue LoadError, StandardError => error
        errors_list[:files_with_error] << file
        errors_list[:errors] << "Error while requiring file #{file}: #{error.message}"
      end
    end

    errors_list
  end

  private_class_method :req_files
end
