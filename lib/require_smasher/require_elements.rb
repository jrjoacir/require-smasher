module RequireElements
  def self.require_elements(elements, require_module)
    elements.uniq!
    errors = []

    elements.each do |element|
      begin
        require_module.req(element)
      rescue => e
        errors << e.message
      end
    end

    return if errors.empty?

    raise StandardError, errors if errors.count > 1
    raise StandardError, errors.first unless errors.empty?
  end
end
