# Handle requiring files
module FileSmasher
  class << self
    def files_by(directory)
      raise StandardError, "Directory '#{directory}' does not exist" unless Dir.exist?(directory)
      Dir.glob(File.join("./#{directory}", '**', '*.rb'))
    end
  end
end
