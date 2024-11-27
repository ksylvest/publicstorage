# frozen_string_literal: true

module PublicStorage
  # Represents an address associated with a facility.
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

    # @param data [Hash]
    #
    # @return [Address]
    def self.parse(data:)
      new(
        street: data['streetAddress'],
        city: data['addressLocality'],
        state: data['addressRegion'],
        zip: data['postalCode']
      )
    end
  end
end
