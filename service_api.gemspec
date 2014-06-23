# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'service_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'service_api'
  spec.version       = ServiceApi::VERSION
  spec.authors       = ['Krzysztof Wawer']
  spec.email         = ['krzysztof.wawer@gmail.com']
  spec.summary       = %q{Set of useful modules, classes for api gems}
  spec.description   = %q{Set of useful modules, classes for api gems}
  spec.homepage     = %q{http://github.com/wafcio/service_api}
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'faraday', '~> 0.9.0'
  spec.add_runtime_dependency 'uri_template', '~> 0.7.0'
  spec.add_runtime_dependency 'queryparams', '~> 0.0.3'
  spec.add_runtime_dependency 'faraday_middleware', '~> 0.9.1'
  spec.add_runtime_dependency 'multi_xml', '~> 0.5.5'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14.1'
end
