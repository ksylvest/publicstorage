# frozen_string_literal: true

module PublicStorage
  # Represents an address associated with a facility.
  class Address
    # @attribute [rw] line1
    #   @return [String]
    attr_accessor :line1

    # @attribute [rw] line2
    #   @return [String]
    attr_accessor :line2

    # @attribute [rw] city
    #   @return [String]
    attr_accessor :city

    # @attribute [rw] state
    #   @return [String]
    attr_accessor :state

    # @attribute [rw] zip
    #   @return [String]
    attr_accessor :zip

    # @param line1 [String]
    # @param line2 [String]
    # @param city [String]
    # @param state [String]
    # @param zip [String]
    def initialize(line1:, line2:, city:, state:, zip:)
      @line1 = line1
      @line2 = line2
      @city = city
      @state = state
      @zip = zip
    end

    # @return [String]
    def inspect
      props = [
        "line1=#{@line1.inspect}",
        "line2=#{@line2.inspect}",
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
        line1: data['line1'],
        line2: data['line2'],
        city: data['city'],
        state: data['stateName'],
        zip: data['postalCode']
      )
    end
  end
end
