module RequireGem
  def self.req(gem)
    raise StandardError, "Gem was not informed" unless gem

    begin
      require gem
    rescue LoadError => e
      raise e, "Error requering gem '#{gem}': #{e.message}"
    rescue => e
      raise StandardError, "Error requering gem '#{gem}': #{e.message}"
    end
  end
end
