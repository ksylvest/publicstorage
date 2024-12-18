# frozen_string_literal: true

module PublicStorage
  # The dimensions (width + depth + sqft) of a price.
  class Dimensions
    SELECTOR = '.unit-size'

    # @attribute [rw] depth
    #   @return [Integer]
    attr_accessor :depth

    # @attribute [rw] width
    #  @return [Integer]
    attr_accessor :width

    # @attribute [rw] sqft
    #   @return [Integer]
    attr_accessor :sqft

    # @param depth [Float]
    # @param width [Float]
    # @param sqft [Integer]
    def initialize(depth:, width:, sqft:)
      @depth = depth
      @width = width
      @sqft = sqft
    end

    # @return [String]
    def inspect
      props = [
        "depth=#{@depth.inspect}",
        "width=#{@width.inspect}",
        "sqft=#{@sqft.inspect}"
      ]
      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @return [String] e.g. "10' × 10' (100 sqft)"
    def text
      "#{format('%g', @width)}' × #{format('%g', @depth)}' (#{@sqft} sqft)"
    end

    # @param data [Hash]
    #
    # @return [Dimensions]
    def self.parse(data:)
      match = data['dimension'].match(/(?<depth>[\d\.]+)'x(?<width>[\d\.]+)'/)
      depth = Float(match[:depth])
      width = Float(match[:width])
      sqft = Integer(depth * width)

      new(depth:, width:, sqft:)
    end
  end
end
