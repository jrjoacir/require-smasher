module RequireDir
  def self.req(directories)
    raise StandardError, 'Directory was not informed' if directories.empty?
    require_files_list(files(directories))
  end

  def self.files(directories)
    files = []
    directories.uniq.each do |directory|
      raise StandardError, "Directory '#{directory}' does not exist" unless Dir.exist?(directory)
      files.concat(Dir.glob(File.join(File.expand_path("./#{directory}"), '**', '*.rb')))
    end
    files
  end

  def self.require_files_list(files, attempt = 0)
    errors_list = require_files(files)

    return if errors_list[:files_with_error].empty?
    attempt += 1 if files == errors_list[:files_with_error]

    raise StandardError, errors_list[:errors] if attempt > 1
    require_files_list(errors_list[:files_with_error], attempt)
  end

  def self.require_files(files)
    errors_list = { files_with_error: [], errors: [] }

    files.uniq.each do |file|
      begin
        require_relative file
      rescue StandardError => error
        errors_list[:files_with_error] << file
        errors_list[:errors] << "Error while requiring file #{file}: #{error.message}"
      end
    end

    errors_list
  end

  private_class_method :files, :require_files, :require_files_list
end
