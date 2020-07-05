# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "require_smasher/version"

Gem::Specification.new do |spec|
  spec.name          = "require_smasher"
  spec.version       = RequireSmasher::VERSION
  spec.authors       = ["Joacir Junior"]
  spec.email         = ["jr.joacir@gmail.com"]

  spec.summary       = %q{A simple way to require ruby files in directories and in its sub-directories, and gems.}
  spec.description   = %q{Require Smasher give you the power to require ruby files in a list of directories and their sub-directories (recursively), a list of ruby files and a list of gems, with just one command.}
  spec.homepage      = "https://github.com/jrjoacir/require-smasher"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir['lib/**/*.rb'] + Dir['bin/**/*']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 2.1.4'
  spec.add_development_dependency 'rake', '~> 13.0', '>= 13.0.1'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'simplecov', '~> 0.18.5'
  spec.add_development_dependency 'rubocop', '~> 0.86.0'
  spec.add_development_dependency 'byebug', '~> 11.1', '>= 11.1.3'
  spec.add_development_dependency 'rubycritic', '~> 4.5', '>= 4.5.1'
end
