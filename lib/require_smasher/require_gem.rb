module RequireGem
  def self.req(gems)
    raise StandardError, 'Gem was not informed' if gems.empty?
    gems.uniq.each { |gem| req_gem(gem) }
  end

  def self.req_gem(gem)
    require gem
  end

  private_class_method :req_gem
end
