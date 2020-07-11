# frozen_string_literal: true

# Classify elements in files or gems

module Classifier
  class << self
    def classify(elements)
      elements.uniq!
      files = elements.select { |element| element_type(element) == :file }
      directories = (elements - files).select { |element| element_type(element) == :directory }
      gems = elements - files - directories
      files << directories.map { |directory| FileSmasher.files_by(directory) }
      { files: files.flatten, gems: gems }
    end

    private

    def element_type(element)
      return :directory if Dir.exist?(element)
      return :file if FileSmasher.file?(element)

      :gem
    end
  end
end
