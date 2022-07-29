# frozen_string_literal: true
version = File.read("VERSION").strip

Gem::Specification.new do |spec|
  spec.name          = 'jekyll-theme-hacker'
  spec.version       = '0.1.1'
  spec.license       = 'MIT'
  spec.authors       = ['William Guilherme', 'GitHub, Inc.']
  spec.email         = ['wguilherme@zscaler.com']
  spec.homepage      = 'https://zscaler-bd-sa.github.io/terraform/'
  spec.summary       = 'DockerLabs'

  spec.files         = `git ls-files -z`.split("\x0").select do |f|
      f.match(%r{^((_includes|_layouts|_sass|assets)/|(LICENSE|README)((\.(txt|md|markdown)|$)))}i)
    end

    spec.platform = Gem::Platform::RUBY
    spec.add_runtime_dependency 'jekyll', '> 3.5', '< 5.0'
    spec.add_runtime_dependency 'jekyll-seo-tag', '~> 2.0'
    spec.add_development_dependency 'html-proofer', '~> 3.0'
    spec.add_development_dependency 'rubocop', '~> 0.50'
    spec.add_development_dependency 'w3c_validators', '~> 1.3'
  end