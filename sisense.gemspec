# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','sisense','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'sisense-cli'
  s.version = Sisense::VERSION
  s.author = 'Adam'
  s.email = 'adamk@nulogy.com'
  s.homepage = 'http://github.com/nulogy/sisense-cli'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A simple command line for interacting with sisense data'
  s.files = `git ls-files`.split("\n")
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','sisense.rdoc']
  s.rdoc_options << '--title' << 'sisense' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'sisense'

  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.13.1')

  s.add_dependency "jwt"
  s.add_dependency "json", "~>1.8"
  s.add_dependency "rest-client", "~>1.7"
  s.add_dependency "highline", "~>1.6"
  s.add_dependency "terminal-table", "~>1.4"
end
