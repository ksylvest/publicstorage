# frozen_string_literal: true

require_relative 'lib/publicstorage/version'

Gem::Specification.new do |spec|
  spec.name = 'publicstorage'
  spec.version = PublicStorage::VERSION
  spec.authors = ['Kevin Sylvestre']
  spec.email = ['kevin@ksylvest.com']

  spec.summary = 'A crawler for PublicStorage.'
  spec.description = 'Uses HTTP.rb to scrape publicstorage.com.'
  spec.homepage = 'https://github.com/ksylvest/publicstorage'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.2.0'

  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = "https://github.com/ksylvest/publicstorage/tree/v#{PublicStorage::VERSION}"
  spec.metadata['changelog_uri'] = "https://github.com/ksylvest/publicstorage/releases/tag/v#{PublicStorage::VERSION}"
  spec.metadata['documentation_uri'] = 'https://publicstorage.ksylvest.com/'

  spec.files = Dir.glob('{bin,lib,exe}/**/*') + %w[README.md Gemfile]
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'http'
  spec.add_dependency 'json'
  spec.add_dependency 'nokogiri'
  spec.add_dependency 'zeitwerk'
end
