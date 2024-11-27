# frozen_string_literal: true

module PublicStorage
  # The rates associated with a price
  class Rates
    # @attribute [rw] nsc
    #   @return [Integer]
    attr_accessor :nsc

    # @attribute [rw] street
    #   @return [Integer]
    attr_accessor :street

    # @attribute [rw] web
    #   @return [Integer]
    attr_accessor :web

    # @param nsc [Integer]
    # @param street [Integer]
    # @param web [Integer]
    def initialize(nsc:, street:, web:)
      @nsc = nsc
      @street = street
      @web = web
    end

    # @return [String]
    def inspect
      props = [
        "nsc=#{@nsc.inspect}",
        "street=#{@street.inspect}",
        "web=#{@web.inspect}"
      ]
      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @param data [Hash]
    #
    # @return [Rates]
    def self.parse(data:)
      new(
        nsc: data['nsc'],
        street: data['street'],
        web: data['web']
      )
    end
  end
end
