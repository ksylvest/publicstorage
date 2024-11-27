# frozen_string_literal: true

module PublicStorage
  # e.g. https://www.publicstorage.com/self-storage-ca-los-angeles/2.html
  class Facility
    SITEMAP_URL = 'https://www.publicstorage.com/sitemap_0-product.xml'

    PRICE_SELECTOR = '.units-results-section .unit-list-group .unit-list-item'

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
      parse(document:)
    end

    # @param document [NokoGiri::XML::Document]
    #
    # @return [Facility]
    def self.parse(document:)
      data = JSON.parse(document.at_css('script[type="application/ld+json"]').text)
      item = data.find { |entry| entry['@type'] == 'SelfStorage' }
      address = Address.parse(data: item['address'])
      geocode = Geocode.parse(data: item['geo'])

      prices = document.css(PRICE_SELECTOR).map { |element| Price.parse(element:) }

      new(address:, geocode:, prices:)
    end
  end
end
