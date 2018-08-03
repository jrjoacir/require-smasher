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
    rescue => e
      begin
        require_dirs(required)
      rescue => f
        errors << e.message
        errors << f.message
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
  raise StandardError, 'No directories was informed' unless directories
  RequireElements.require_elements(directories, RequireDir)
end

def require_gems(*gems)
  raise StandardError, 'No gems was informed' unless gems
  RequireElements.require_elements(gems, RequireGem)
end
