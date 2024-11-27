# frozen_string_literal: true

module PublicStorage
  # A price associated with a unit.
  class Price
    # @attribute [rw] uid
    #   @return [String]
    attr_accessor :uid

    # @attribute [rw] availability
    #   @return [Availability]
    attr_accessor :availability

    # @attribute [rw] dimensions
    #   @return [Dimensions]
    attr_accessor :dimensions

    # @attribute [rw] rates
    #   @return [Rates]
    attr_accessor :rates

    # @param uid [String]
    # @param availability [Availability]
    # @param dimensions [Dimensions]
    # @param rates [Rates]
    def initialize(uid:, availability:, dimensions:, rates:)
      @uid = uid
      @availability = availability
      @dimensions = dimensions
      @rates = rates
    end

    # @return [String]
    def inspect
      props = [
        "uid=#{@uid.inspect}",
        "availability=#{@availability.inspect}",
        "dimensions=#{@dimensions.inspect}",
        "rates=#{@rates.inspect}"
      ]
      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @param data [Hash]
    #
    # @return [Price]
    def self.parse(data:)
      availability = Availability.parse(data: data['availability'])
      dimensions = Dimensions.parse(data: data['dimensions'])
      rates = Rates.parse(data: data['rates'])
      new(
        uid: data['uid'],
        availability: availability,
        dimensions: dimensions,
        rates: rates
      )
    end
  end
end
