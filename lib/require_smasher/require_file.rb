# Handle requiring files
module RequireFile
  def self.require_files(files, attempt = 0)
    raise StandardError, 'File was not informed' if files.empty?
    errors_list = req_files(files)
    files_with_error = errors_list[:files_with_error]

    return if files_with_error.empty?
    attempt += 1 if files == files_with_error

    raise StandardError, errors_list[:errors] if attempt > 1
    require_files(files_with_error, attempt)
  end

  def self.require_directories(directories)
    raise StandardError, 'Directory was not informed' if directories.empty?
    require_files(files(directories))
  end

  def self.files(directories)
    raise StandardError, 'Directory was not informed' if directories.empty?

    files = []
    directories.uniq.each do |directory|
      files.concat(ruby_files_by(directory))
    end

    files
  end

  def self.ruby_files_by(directory)
    raise StandardError, "Directory '#{directory}' does not exist" unless Dir.exist?(directory)
    Dir.glob(File.join("./#{directory}", '**', '*.rb'))
  end

  def self.req_files(files)
    errors_list = { files_with_error: [], errors: [] }

    files.uniq.each do |file|
      begin
        require_relative File.expand_path("./#{file}")
      rescue LoadError, StandardError => error
        errors_list[:files_with_error] << file
        errors_list[:errors] << "Error while requiring file #{file}: #{error.message}"
      end
    end

    errors_list
  end

  private_class_method :req_files, :ruby_files_by
end
