# frozen_string_literal: true

module PublicStorage
  # e.g. https://www.publicstorage.com/self-storage-ca-los-angeles/2.html
  class Facility
    SITEMAP_URL = 'https://www.publicstorage.com/sitemap_0-product.xml'

    PRICE_SELECTOR = '.units-results-section .unit-list-group .unit-list-item'
    LD_SELECTOR = 'script[type="application/ld+json"]'

    ID_REGEX = /(?<id>\d+)\.html/

    # @attribute [rw] id
    #   @return [Integer]
    attr_accessor :id

    # @attribute [rw] name
    #   @return [String]
    attr_accessor :name

    # @attribute [rw] address
    #   @return [Address]
    attr_accessor :address

    # @attribute [rw] geocode
    #   @return [Geocode]
    attr_accessor :geocode

    # @attribute [rw] prices
    #   @return [Array<Price>]
    attr_accessor :prices

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
      data = parse_ld(document:)
      id = Integer(data['url'].match(ID_REGEX)[:id])
      name = data['name']
      address = Address.parse(data: data['address'])
      geocode = Geocode.parse(data: data['geo'])

      prices = document.css(PRICE_SELECTOR).map { |element| Price.parse(element:) }

      new(id:, name:, address:, geocode:, prices:)
    end

    # @param document [NokoGiri::XML::Document]
    #
    # @return [Hash]
    def self.parse_ld(document:)
      JSON.parse(document.at_css(LD_SELECTOR).text).find { |entry| entry['@type'] == 'SelfStorage' }
    end

    def self.crawl
      sitemap.links.each do |link|
        url = link.loc

        facility = fetch(url:)
        puts facility.text

        facility.prices.each do |price|
          puts price.text
        end

        puts
      end
    end

    # @param id [String]
    # @param name [String]
    # @param address [Address]
    # @param geocode [Geocode]
    # @param prices [Array<Price>]
    def initialize(id:, name:, address:, geocode:, prices:)
      @id = id
      @name = name
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

    # @return [String]
    def text
      "#{@id} | #{@name} | #{@address.text} | #{@geocode.text}"
    end
  end
end
