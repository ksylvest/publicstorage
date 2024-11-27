# frozen_string_literal: true

module PublicStorage
  # The core configuration.
  class Config
    # @attribute [rw] user_agent
    #   @return [String]
    attr_accessor :user_agent

    # @attribute [rw] timeout
    #   @return [Integer]
    attr_accessor :timeout

    def initialize
      @user_agent = ENV.fetch('PUBLICSTORAGE_USER_AGENT', "publicstorage.rb/#{VERSION}")
      @timeout = Integer(ENV.fetch('PUBLICSTORAGE_TIMEOUT', 60))
    end
  end
end
