require 'require_smasher/version'
require 'require_smasher/file_smasher'
require 'require_smasher/classifier'
require 'require_smasher/require_file'

def require_all(*required_list)
  classified = Classifier.classify(required_list)
  gems = classified[:gems]
  files = classified[:files]

  gems.uniq.each { |gem| require gem } unless gems.empty?
  RequireFile.require(files) unless files.empty?
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
  raise StandardError, 'Gem was not informed' if gems.empty?

  gems.uniq.each { |gem| require gem }
end

def require_files(*files)
  RequireFile.require(files)
end
