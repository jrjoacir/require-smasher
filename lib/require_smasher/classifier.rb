# Classify elements in files or gems

module Classifier
  class << self
    def classify(elements)
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

    private

    def element_type(element)
      return :directory if Dir.exist?(element)
      return :file if FileSmasher.file?(element)
      :gem
    end
  end
end
