# Deprecated
module RequireDir
  def self.req(directories)
    RequireFile.require_directories(directories)
  end
end
