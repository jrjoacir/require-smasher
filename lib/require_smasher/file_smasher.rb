# frozen_string_literal: true

# Find files

module FileSmasher
  class << self
    def files_by(directory)
      raise DirNotExistError, "Directory '#{directory}' does not exist" unless Dir.exist?(directory)

      Dir.glob("./#{directory}/**/*.rb")
    end

    def files(directories)
      raise DirNotInformedError if directories.empty?

      files = []
      directories.uniq.each do |directory|
        files.concat(FileSmasher.files_by(directory))
      end

      files
    end

    def file?(element)
      file = File.expand_path("./#{element}")
      return true if File.file?(file)
      return false if element.include?('.')

      File.file?("#{file}.rb")
    end
  end
end
