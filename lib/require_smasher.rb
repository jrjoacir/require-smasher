require 'require_smasher/version'
require 'require_smasher/require_gem'
require 'require_smasher/require_file'
require 'require_smasher/require_dir'

def require_all(*required_list)
  directories = []
  gems = []

  required_list.uniq.each do |required|
    directory = Dir.exist?(required)
    directories << required if directory
    gems << required unless directory
  end

  require_gem(gems) unless gems.empty?
  require_dir(directories) unless directories.empty?
end

def require_gem(gems)
  return RequireGem.req([gems]) if gems.instance_of?(String)
  RequireGem.req(gems)
end

def require_dir(directories)
  return RequireDir.req([directories]) if directories.instance_of?(String)
  RequireDir.req(directories)
end

def require_dirs(*directories)
  require_dir(directories)
end

def require_gems(*gems)
  require_gem(gems)
end
