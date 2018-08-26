# Handle requiring gems
module RequireGem
  def self.req(gems)
    raise StandardError, 'Gem was not informed' if gems.empty?
    gems.uniq.each { |gem| require gem }
  end
end
