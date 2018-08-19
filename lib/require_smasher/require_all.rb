module RequireAll
  def self.req(required_list)
    result = required_list_classified(required_list)

    require_gem(result[:gems]) unless result[:gems].empty?
    require_file(result[:files]) unless result[:files].empty?
  end

  def self.required_list_classified(elements)
    result = { files: [], gems: [] }

    elements.uniq.each do |element|
      is_file = File.file?(element)
      is_directory = Dir.exist?(element)
      is_gem = !(is_file || is_directory)

      result[:files] << element if is_file
      result[:files].concat(RequireFile.files([element])) if is_directory
      result[:gems] << element if is_gem
    end
    result
  end

  private_class_method :required_list_classified
end
