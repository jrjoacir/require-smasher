module RequireGem
  def self.req(gem)
    raise StandardError, "Gem was not informed" unless gem

    begin
      require gem
    rescue LoadError => error
      raise error, "Error requering gem '#{gem}': #{error.message}"
    rescue => error
      raise StandardError, "Error requering gem '#{gem}': #{error.message}"
    end
  end
end
