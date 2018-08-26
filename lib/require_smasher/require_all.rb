# Handle requiring files inside directories, files and gems
module RequireAll
  def self.req(required_list)
    result = required_list_classified(required_list)
    gems = result[:gems]
    files = result[:files]

    RequireGem.req(gems) unless gems.empty?
    RequireFile.require_files(files) unless files.empty?
  end

  def self.required_list_classified(elements)
    files = []
    gems = []

    elements.uniq.each do |element|
      case element_type(element)
      when :file
        files << element
      when :directory
        files.concat(RequireFile.files([element]))
      else
        gems << element
      end
    end
    { files: files, gems: gems }
  end

  def self.file?(element)
    file = File.expand_path("./#{element}")
    return true if File.file?(file)
    return false if element.include?('.')
    File.file?("#{file}.rb")
  end

  def self.element_type(element)
    return :file if file?(element)
    return :directory if Dir.exist?(element)
    :gem
  end

  private_class_method :required_list_classified, :file?, :element_type
end
