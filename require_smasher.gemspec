# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "require_smasher/version"

Gem::Specification.new do |spec|
  spec.name          = "require_smasher"
  spec.version       = RequireSmasher::VERSION
  spec.authors       = ["Joacir Junior"]
  spec.email         = ["jr.joacir@gmail.com"]

  spec.summary       = %q{Um jeito fácil de dar 'require' em seus diretórios e gems.}
  spec.description   = %q{Require_Smasher dá à você o poder de importar (require) arquivos de um diretório (e seus sub-diretórios) e gems com o mesmo command (se quiser).}
  #spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.16"
  spec.add_development_dependency "rubocop", "~> 0.58"
end
