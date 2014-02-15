# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'undo/storage/redis/gemspec'
require 'undo/storage/redis'

Gem::Specification.new do |spec|
  spec.name          = "undo-storage-redis"
  spec.version       = Undo::Storage::Redis::Gemspec::VERSION
  spec.authors       = ["Alexander Paramonov"]
  spec.email         = ["alexander.n.paramonov@gmail.com"]
  spec.summary       = %q{Redis storage adapter for Undo}
  spec.description   = %q{Redis storage adapter for Undo}
  spec.homepage      = "http://github.com/AlexParamonov/undo-storage-redis"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "undo-serializer-null", "~> 0.0.1"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0.0.beta1"

  if Undo::Storage::Redis::Gemspec::RUNNING_ON_CI
    spec.add_development_dependency "coveralls"
  else
    spec.add_development_dependency "pry"
    spec.add_development_dependency "pry-plus" if "ruby" == RUBY_ENGINE
  end
end
