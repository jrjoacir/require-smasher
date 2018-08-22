module RequireAll
  def self.req(required_list)
    result = required_list_classified(required_list)

    RequireGem.req(result[:gems]) unless result[:gems].empty?
    RequireFile.require_files(result[:files]) unless result[:files].empty?
  end

  def self.required_list_classified(elements)
    result = { files: [], gems: [] }

    elements.uniq.each do |element|
      is_file = file?(element)
      is_directory = Dir.exist?(element)
      is_gem = !(is_file || is_directory)

      result[:files] << element if is_file
      result[:files].concat(RequireFile.files([element])) if is_directory
      result[:gems] << element if is_gem
    end
    result
  end

  def self.file?(element)
    file = File.expand_path("./#{element}")
    return true if File.file?(file)
    return false if element.include?('.')
    File.file?("#{file}.rb")
  end

  private_class_method :required_list_classified, :file?
end
