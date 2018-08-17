module RequireDir
  def self.req(directories)
    raise StandardError, 'Directory was not informed' if directories.empty?
    RequireFile.req(files(directories))
  end

  def self.files(directories)
    files = []
    directories.uniq.each do |directory|
      raise StandardError, "Directory '#{directory}' does not exist" unless Dir.exist?(directory)
      files.concat(Dir.glob(File.join(File.expand_path("./#{directory}"), '**', '*.rb')))
    end
    files
  end

  private_class_method :files
end
