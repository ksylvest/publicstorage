# frozen_string_literal: true

module PublicStorage
  # The price (id + dimensions + rate) for a facility
  class Price
    GTM_SELECTOR = 'button[data-gtmdata]'

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

    # @return [String] e.g. "123 | 5' × 5' (25 sqft) | $100 (street) / $90 (web)"
    def text
      "#{@id} | #{@dimensions.text} | #{@rates.text}"
    end

    # @param element [Nokogiri::XML::Element]
    #
    # @return [Price]
    def self.parse(element:)
      data = JSON.parse(element.at(GTM_SELECTOR).attribute('data-gtmdata'))

      rates = Rates.parse(data:)
      dimensions = Dimensions.parse(data:)

      new(
        id: element.attr('data-unitid'),
        dimensions: dimensions,
        rates: rates
      )
    end
  end
end
