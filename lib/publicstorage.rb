# frozen_string_literal: true

require 'http'
require 'nokogiri'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect 'publicstorage' => 'PublicStorage'
loader.inflector.inflect 'cli' => 'CLI'
loader.setup

# An interface for PublicStorage.
module PublicStorage
  class Error < StandardError; end

  # @return [Config]
  def self.config
    @config ||= Config.new
  end

  # @yield [config]
  # @yieldparam config [Config]
  def self.configure
    yield config
  end
end
