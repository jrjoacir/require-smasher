module RequireDir
  def self.req(directories)
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

  def self.require_files(files, attempt = 0)
    files_with_error = []
    errors = []

    files.each do |file|
      begin
        require_relative file
      rescue StandardError => error
        files_with_error << file
        errors << { file: file, error: error.message }
      end
    end

    return if files_with_error.count <= 0

    attempt += 1 if files == files_with_error

    raise StandardError, errors if attempt > 1
    require_files(files_with_error, attempt)
  end

  private_class_method :files, :require_files
end
