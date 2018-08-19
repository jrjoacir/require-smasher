require 'require_smasher/version'
require 'require_smasher/require_gem'
require 'require_smasher/require_file'
require 'require_smasher/require_dir'
require 'require_smasher/require_all'

def require_all(*required_list)
  RequireAll.req(required_list)
end

def require_gem(gems)
  return RequireGem.req([gems]) if gems.instance_of?(String)
  RequireGem.req(gems)
end

def require_dir(directories)
  return RequireFile.require_directories([directories]) if directories.instance_of?(String)
  RequireFile.require_directories(directories)
end

def require_file(files)
  return RequireFile.require_files([files]) if files.instance_of?(String)
  RequireFile.require_files(files)
end

def require_dirs(*directories)
  require_dir(directories)
end

def require_gems(*gems)
  require_gem(gems)
end

def require_files(*files)
  require_file(files)
end
