$:.push File.expand_path('../lib', __FILE__)
require 'bambora/version'

Gem::Specification.new do |s|
  s.platform      = Gem::Platform::RUBY
  s.name          = 'bambora'
  s.version       = Bambora::VERSION
  s.date          = '2018-08-10'
  s.summary       = "Bambora Ruby SDK"
  s.description   = "Accept payments using Bambora and Ruby"
  s.authors       = ["Brent Owens", "Colin Walker", "Tom Mengda", "Maxime Gauthier"]
  s.email         = 'bowens@beanstream.com'
  s.homepage      = 'http://dev.na.bambora.com'
  s.license       = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'rest-client'
  s.add_dependency 'json'
  s.add_dependency 'chronic'
  s.add_dependency 'activesupport'

  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'factory_bot'
  s.add_development_dependency 'vcr', '~> 4.0'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rake'
end
