# frozen_string_literal: true

# Handle requiring files

module RequireFile
  class << self
    def require(files, total = nil)
      raise FileNotInformedError if files.empty?

      results = require_files(files)
      results.select! { |r| r[:error] }
      return if results.empty?
      raise RequireFileError, (results.map { |result| result[:message] }) if total == results.count

      require(results.map { |result| result[:file] }, results.count)
    end

    def require_directories(directories)
      raise DirNotInformedError if directories.empty?

      require(FileSmasher.files(directories))
    end

    private

    def require_files(files)
      files.uniq.map do |file|
        require_relative File.expand_path("./#{file}")
        { file: file, error: false, message: nil }
      rescue LoadError, StandardError => e
        { file: file, error: true, message: "Error while requiring file #{file}: #{e.message}" }
      end
    end
  end
end
