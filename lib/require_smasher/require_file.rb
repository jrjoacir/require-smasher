module RequireFile
  def self.req(files, attempt = 0)
    errors_list = require_files(files)

    return if errors_list[:files_with_error].empty?
    attempt += 1 if files == errors_list[:files_with_error]

    raise StandardError, errors_list[:errors] if attempt > 1
    req(errors_list[:files_with_error], attempt)
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

  private_class_method :require_files
end
