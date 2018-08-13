require 'require_smasher/version'
require 'require_smasher/require_gem'
require 'require_smasher/require_dir'
require 'require_smasher/require_elements'

def require_all(*required_list)
  required_list.uniq!
  errors = []

  required_list.each do |required|
    begin
      require_gems(required)
    rescue StandardError => gem_error
      begin
        require_dirs(required)
      rescue StandardError => dir_error
        errors << gem_error.message
        errors << dir_error.message
      end
    end
  end

  raise StandardError, errors unless errors.empty?
end

def require_gem(gem)
  require_gems(gem)
end

def require_dir(directory)
  require_dirs(directory)
end

def require_dirs(*directories)
  raise StandardError, 'No directories was informed' if directories.empty?
  RequireElements.require_elements(directories, RequireDir)
end

def require_gems(*gems)
  raise StandardError, 'No gems was informed' if gems.empty?
  RequireElements.require_elements(gems, RequireGem)
end
