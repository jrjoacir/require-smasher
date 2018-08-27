require 'require_smasher/version'
require 'require_smasher/file_smasher'
require 'require_smasher/require_gem'
require 'require_smasher/require_file'
require 'require_smasher/require_all'

def require_all(*required_list)
  RequireAll.req(required_list)
end

def require_gem(gem)
  require gem
  gem
end

def require_dir(directory)
  RequireFile.require_directories([directory])
end

def require_file(file)
  require_relative File.expand_path("./#{file}")
  nil
end

def require_dirs(*directories)
  RequireFile.require_directories(directories)
end

def require_gems(*gems)
  RequireGem.req(gems)
end

def require_files(*files)
  RequireFile.require_files(files)
end
