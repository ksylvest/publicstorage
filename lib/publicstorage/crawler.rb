# frozen_string_literal: true

module PublicStorage
  # Used to fetch and parse either HTML or XML via a URL.
  class Crawler
    # Raised for unexpected HTTP responses.
    class FetchError < StandardError
      # @param url [String]
      # @param response [HTTP::Response]
      def initialize(url:, response:)
        super("url=#{url} status=#{response.status.inspect} body=#{response.body.inspect}")
      end
    end

    # @param url [String]
    # @raise [FetchError]
    # @return [Nokogiri::HTML::Document]
    def self.html(url:)
      new.html(url:)
    end

    # @param url [String]
    # @raise [FetchError]
    # @return [Nokogiri::XML::Document]
    def self.xml(url:)
      new.xml(url:)
    end

    # @param url [String]
    # @return [HTTP::Response]
    def fetch(url:)
      response = HTTP.get(url)
      raise FetchError(url:, response: response.flush) unless response.status.ok?

      response
    end

    # @param url [String]
    # @raise [FetchError]
    # @return [Nokogiri::XML::Document]
    def html(url:)
      Nokogiri::HTML(String(fetch(url:).body))
    end

    # @param url [String]
    # @raise [FetchError]
    # @return [Nokogiri::XML::Document]
    def xml(url:)
      Nokogiri::XML(String(fetch(url:).body))
    end
  end
end
