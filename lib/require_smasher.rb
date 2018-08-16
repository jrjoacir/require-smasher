require 'require_smasher/version'
require 'require_smasher/require_gem'
require 'require_smasher/require_dir'

def require_all(*required_list)
  directories = []

  required_list.uniq.each do |required|
    begin
      require_gem(required)
    rescue StandardError, LoadError
      directories << required
    end
  end

  # GENERALIZAR ERRO PARA GEM E DIRETORIO. Tratar raises especificos de diretorio e concatenar mensagem de não achou gem.
  # Como mostrar os dois erros?
  begin
    require_dir(directories) unless directories.empty?
  rescue StandardError, LoadError => error
    raise StandardError, "Error attempting to require gem or directory. #{error.message}"
  end
end

def require_gem(gems)
  raise StandardError, 'No gem was informed' if gems.empty?
  return RequireGem.req([gems]) if gems.instance_of?(String)
  RequireGem.req(gems)
end

def require_dir(directories)
  raise StandardError, 'No directory was informed' if directories.empty?
  return RequireDir.req([directories]) if directories.instance_of?(String)
  RequireDir.req(directories)
end

def require_dirs(*directories)
  require_dir(directories)
end

def require_gems(*gems)
  require_gem(gems)
end
