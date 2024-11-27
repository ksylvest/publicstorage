# frozen_string_literal: true

module PublicStorage
  # The rates associated with a price
  class Rates
    STREET_SELECTOR = '.unit-prices .unit-pricing .unit-strike-through-price'
    WEB_SELECTOR = '.unit-prices .unit-pricing .unit-price'

    # @attribute [rw] street
    #   @return [Integer]
    attr_accessor :street

    # @attribute [rw] web
    #   @return [Integer]
    attr_accessor :web

    # @param street [Integer]
    # @param web [Integer]
    def initialize(street:, web:)
      @street = street
      @web = web
    end

    # @return [String]
    def inspect
      props = [
        "street=#{@street.inspect}",
        "web=#{@web.inspect}"
      ]
      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @param element [Nokogiri::XML::Element]
    #
    # @return [Rates]
    def self.parse(element:)
      street = Integer(element.at(STREET_SELECTOR).text.match(/(?<value>\d+)/)[:value])
      web = Integer(element.at(WEB_SELECTOR).text.match(/(?<value>\d+)/)[:value])
      new(street:, web:)
    end
  end
end
