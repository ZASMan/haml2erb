$:.push File.expand_path('lib', __dir__)
require 'haml2erb/version'

Gem::Specification.new do |s|
  s.name        = 'haml2erb'
  s.version     = Haml2Erb::VERSION
  s.authors     = ['Elia Schito']
  s.email       = ['perlelia@gmail.com']
  s.homepage    = ''
  s.summary     = 'Convert Haml templates to Erb!'
  s.description = 'Converts Haml templates to Erb templates using the official Haml::Engine'

  s.rubyforge_project = 'haml2erb'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"

  s.add_runtime_dependency     'haml', '~> 3.1.3'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 2.0'
end
