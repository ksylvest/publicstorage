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

    # @attribute [rw] features
    #   @return [Features]
    attr_accessor :features

    # @attribute [rw] rates
    #   @return [Rates]
    attr_accessor :rates

    # @param id [String]
    # @param dimensions [Dimensions]
    # @param features [Features]
    # @param rates [Rates]
    def initialize(id:, dimensions:, features:, rates:)
      @id = id
      @dimensions = dimensions
      @features = features
      @rates = rates
    end

    # @return [String]
    def inspect
      props = [
        "id=#{@id.inspect}",
        "dimensions=#{@dimensions.inspect}",
        "features=#{@features.inspect}",
        "rates=#{@rates.inspect}"
      ]
      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @return [String] e.g. "123 | 5' × 5' (25 sqft) | $100 (street) / $90 (web) | Climate Controlled"
    def text
      "#{@id} | #{@dimensions.text} | #{@rates.text} | #{@features.text}"
    end

    # @param element [Nokogiri::XML::Element]
    #
    # @return [Price]
    def self.parse(element:)
      data = JSON.parse(element.at(GTM_SELECTOR).attribute('data-gtmdata'))

      rates = Rates.parse(data:)
      dimensions = Dimensions.parse(data:)
      features = Features.parse(data:)

      new(
        id: element.attr('data-unitid'),
        dimensions: dimensions,
        features: features,
        rates: rates
      )
    end
  end
end
