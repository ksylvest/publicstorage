# frozen_string_literal: true

module PublicStorage
  # The address (street + city + state + zip) of a facility.
  class Address
    # @attribute [rw] street
    #   @return [String]
    attr_accessor :street

    # @attribute [rw] city
    #   @return [String]
    attr_accessor :city

    # @attribute [rw] state
    #   @return [String]
    attr_accessor :state

    # @attribute [rw] zip
    #   @return [String]
    attr_accessor :zip

    # @param street [String]
    # @param city [String]
    # @param state [String]
    # @param zip [String]
    def initialize(street:, city:, state:, zip:)
      @street = street
      @city = city
      @state = state
      @zip = zip
    end

    # @return [String]
    def inspect
      props = [
        "street=#{@street.inspect}",
        "city=#{@city.inspect}",
        "state=#{@state.inspect}",
        "zip=#{@zip.inspect}"
      ]
      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @return [String]
    def text
      "#{street}, #{city}, #{state} #{zip}"
    end

    # @param data [Hash]
    #
    # @return [Address]
    def self.parse(data:)
      new(
        street: stripe_leading_or_trailing_null(data['streetAddress']),
        city: data['addressLocality'],
        state: data['addressRegion'],
        zip: data['postalCode']
      )
    end

    # NOTE: this fixes a bug w/ publicstorage that currently exists where addresses have a leading / trailing null.
    #
    # @param value [String]
    #
    # @return [String]
    def self.stripe_leading_or_trailing_null(value)
      match = value.match(/\A(?:null)?(?<text>.*?)(?:null)?\z/)
      match[:text]
    end
  end
end
