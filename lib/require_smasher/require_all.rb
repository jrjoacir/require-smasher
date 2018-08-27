# Handle requiring files inside directories, files and gems
module RequireAll
  class << self
    def req(required_list)
      result = required_list_classified(required_list)
      gems = result[:gems]
      files = result[:files]

      RequireGem.req(gems) unless gems.empty?
      RequireFile.require_files(files) unless files.empty?
    end

    private

    def required_list_classified(elements)
      files = []
      gems = []

      elements.uniq.each do |element|
        case element_type(element)
        when :file then files << element
        when :directory then files.concat(FileSmasher.files_by(element))
        else gems << element
        end
      end
      { files: files, gems: gems }
    end

    def file?(element)
      file = File.expand_path("./#{element}")
      return true if File.file?(file)
      return false if element.include?('.')
      File.file?("#{file}.rb")
    end

    def element_type(element)
      return :directory if Dir.exist?(element)
      return :file if file?(element)
      :gem
    end
  end
end
