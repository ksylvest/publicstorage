# frozen_string_literal: true

module PublicStorage
  # The dimensions (width + depth + height) of a price.
  class Dimensions
    DEFAULT_HEIGHT = 8.0 # feet

    SELECTOR = '.unit-size'

    # @attribute [rw] depth
    #   @return [Integer]
    attr_accessor :depth

    # @attribute [rw] width
    #  @return [Integer]
    attr_accessor :width

    # @attribute [rw] height
    #  @return [Integer]
    attr_accessor :height

    # @param depth [Float]
    # @param width [Float]
    # @param height [Float]
    def initialize(depth:, width:, height: DEFAULT_HEIGHT)
      @depth = depth
      @width = width
      @height = height
    end

    # @return [String]
    def inspect
      props = [
        "depth=#{@depth.inspect}",
        "width=#{@width.inspect}",
        "height=#{@height.inspect}"
      ]
      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @return [String] e.g. "10' × 10' (100 sqft)"
    def text
      "#{format('%g', @width)}' × #{format('%g', @depth)}' (#{sqft} sqft)"
    end

    # @return [Integer]
    def sqft
      Integer(@width * @depth)
    end

    # @return [Integer]
    def cuft
      Integer(@width * @depth * @height)
    end

    # @param data [Hash]
    #
    # @return [Dimensions]
    def self.parse(data:)
      match = data['dimension'].match(/(?<depth>[\d\.]+)'x(?<width>[\d\.]+)'/)
      depth = Float(match[:depth])
      width = Float(match[:width])

      new(depth:, width:, height: DEFAULT_HEIGHT)
    end
  end
end
