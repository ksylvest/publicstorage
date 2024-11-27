# frozen_string_literal: true

module PublicStorage
  # e.g. https://www.publicstorage.com/self-storage-ca-los-angeles/2.html
  class Facility
    SITEMAP_URL = 'https://www.publicstorage.com/sitemap_0-product.xml'

    # @attribute [rw] address
    #   @return [Address]
    attr_accessor :address

    # @attribute [rw] geocode
    #   @return [Geocode]
    attr_accessor :geocode

    # @attribute [rw] prices
    #   @return [Array<Price>]
    attr_accessor :prices

    # @param address [Address]
    # @param geocode [Geocode]
    # @param prices [Array<Price>]
    def initialize(address:, geocode:, prices:)
      @address = address
      @geocode = geocode
      @prices = prices
    end

    # @return [String]
    def inspect
      props = [
        "address=#{@address.inspect}",
        "geocode=#{@geocode.inspect}",
        "prices=#{@prices.inspect}"
      ]
      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @return [Sitemap]
    def self.sitemap
      Sitemap.fetch(url: SITEMAP_URL)
    end

    # @param url [String]
    #
    # @return [Facility]
    def self.fetch(url:)
      document = Crawler.html(url:)
      data = JSON.parse(document.at('#__NEXT_DATA__').text)
      parse(data:)
    end

    # @param data [Hash]
    #
    # @return [Facility]
    def self.parse(data:)
      page_data = data.dig('props', 'pageProps', 'pageData', 'data')
      facility_data = page_data.dig('facilityData', 'data')
      unit_classes = page_data.dig('unitClasses', 'data', 'unitClasses')

      address = Address.parse(data: facility_data['store']['address'])
      geocode = Geocode.parse(data: facility_data['store']['geocode'])
      prices = unit_classes.map { |price_data| Price.parse(data: price_data) }

      new(address:, geocode:, prices:)
    end
  end
end
