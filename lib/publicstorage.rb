# frozen_string_literal: true

require 'http'
require 'nokogiri'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect 'publicstorage' => 'PublicStorage'
loader.inflector.inflect 'cli' => 'CLI'
loader.setup

module PublicStorage
  class Error < StandardError; end
end
