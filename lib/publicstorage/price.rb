# frozen_string_literal: true

module PublicStorage
  # A price associated with a unit.
  class Price
    # @attribute [rw] id
    #   @return [String]
    attr_accessor :id

    # @attribute [rw] dimensions
    #   @return [Dimensions]
    attr_accessor :dimensions

    # @attribute [rw] rates
    #   @return [Rates]
    attr_accessor :rates

    # @param id [String]
    # @param dimensions [Dimensions]
    # @param rates [Rates]
    def initialize(id:, dimensions:, rates:)
      @id = id
      @dimensions = dimensions
      @rates = rates
    end

    # @return [String]
    def inspect
      props = [
        "id=#{@id.inspect}",
        "dimensions=#{@dimensions.inspect}",
        "rates=#{@rates.inspect}"
      ]
      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @param element [Nokogiri::XML::Element]
    #
    # @return [Price]
    def self.parse(element:)
      rates = Rates.parse(element:)
      dimensions = Dimensions.parse(element:)

      new(
        id: element.attr('data-unitid'),
        dimensions: dimensions,
        rates: rates
      )
    end
  end
end
