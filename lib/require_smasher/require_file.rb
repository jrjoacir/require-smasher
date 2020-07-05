# frozen_string_literal: true

# Handle requiring files

module RequireFile
  class << self
    def require(files)
      raise FileNotInformedError if files.empty?

      errors_list = require_files(files)
      files_with_error = errors_list[:files_with_error]

      return if files_with_error.empty?

      raise RequireFileError, errors_list[:errors] if files == files_with_error

      require(files_with_error)
    end

    def require_directories(directories)
      raise DirNotInformedError if directories.empty?

      require(FileSmasher.files(directories))
    end

    private

    def require_files(files)
      errors_list = { files_with_error: [], errors: [] }

      files.uniq.each do |file|
        begin
          require_relative File.expand_path("./#{file}")
        rescue LoadError, StandardError => e
          errors_list[:files_with_error] << file
          errors_list[:errors] << "Error while requiring file #{file}: #{e.message}"
        end
      end

      errors_list
    end
  end
end
