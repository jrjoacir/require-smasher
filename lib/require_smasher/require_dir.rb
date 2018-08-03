module RequireDir
  def self.req(directory)
    require_files(files(directory))
  end

  def self.files(directory)
    raise StandardError, "Directory was not informed" unless directory
    raise StandardError, "Directory '#{directory}' does not exist" unless Dir.exist?(directory)
    Dir.glob(File.join(File.expand_path("./#{directory}"), '**', '*.rb'))
  end

  def self.require_files(files, attempt = 0)
    files_with_error = []
    errors = []

    files.each do |f|
      begin
        require_relative f
      rescue => e
        files_with_error << f
        errors << {file: f, error: e.message}
      end
    end

    return if files_with_error.count <= 0

    attempt += 1 if files == files_with_error

    if attempt < 2
      require_files(files_with_error, attempt)
    else
      raise StandardError, errors
    end
  end

  private_class_method :files, :require_files
end
