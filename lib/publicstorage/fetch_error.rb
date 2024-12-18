# frozen_string_literal: true

module PublicStorage
  # Raised for unexpected HTTP responses.
  class FetchError < StandardError
    # @param url [String]
    # @param response [HTTP::Response]
    def initialize(url:, response:)
      super("url=#{url} status=#{response.status.inspect} body=#{response.body.inspect}")
    end
  end
end
