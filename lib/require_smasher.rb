# frozen_string_literal: true

require 'require_smasher/version'
require 'require_smasher/file_smasher'
require 'require_smasher/classifier'
require 'require_smasher/require_file'
require 'require_smasher/errors/base_error'
require 'require_smasher/errors/not_informed_error'
require 'require_smasher/errors/not_informed_error/dir_not_informed_error'
require 'require_smasher/errors/not_informed_error/file_not_informed_error'
require 'require_smasher/errors/not_informed_error/gem_not_informed_error'
require 'require_smasher/errors/not_exist_error'
require 'require_smasher/errors/not_exist_error/dir_not_exist_error'
require 'require_smasher/errors/require_file_error'

def require_all(*required_list)
  classified = Classifier.classify(required_list)
  files = classified[:files]

  classified[:gems].uniq.each { |gem| require gem }
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
  raise GemNotInformedError if gems.empty?

  gems.uniq.each { |gem| require gem }
end

def require_files(*files)
  RequireFile.require(files)
end
