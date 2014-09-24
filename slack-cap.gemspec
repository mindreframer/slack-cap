# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slack-cap/version'

Gem::Specification.new do |spec|
  spec.name          = "slack-cap"
  spec.version       = Slack::Cap::VERSION
  spec.authors       = ["Roman Heinrich"]
  spec.email         = ["roman.heinrich@gmail.com"]
  spec.summary       = %q{Capistrano plugin to enable notifications to Slack}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/mindreframer/slack-cap"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "slack-notifier", "~> 0.6"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
