# Handle requiring gems
module RequireGem
  class << self
    def req(gems)
      raise StandardError, 'Gem was not informed' if gems.empty?
      gems.uniq.each { |gem| require gem }
    end
  end
end
