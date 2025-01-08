# frozen_string_literal: true

module PublicStorage
  # e.g. https://www.publicstorage.com/self-storage-ca-los-angeles/2.html
  class Facility
    SITEMAP_URL = 'https://www.publicstorage.com/sitemap_0-product.xml'

    DEFAULT_PHONE = '1-800-742-8048'
    DEFAULT_EMAIL = 'customerservice@publicstorage.com'

    NAME_SELECTOR = '.plp-page-header'
    PRICE_SELECTOR = '.units-results-section .unit-list-group .unit-list-item'
    LD_SELECTOR = 'script[type="application/ld+json"]'

    ID_REGEX = /(?<id>\d+)\.html/

    # @attribute [rw] id
    #   @return [Integer]
    attr_accessor :id

    # @attribute [rw] url
    #   @return [String]
    attr_accessor :url

    # @attribute [rw] name
    #   @return [String]
    attr_accessor :name

    # @attribute [rw] phone
    #   @return [String]
    attr_accessor :phone

    # @attribute [rw] email
    #   @return [String]
    attr_accessor :email

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
      parse(url:, document:)
    end

    # @param document [NokoGiri::XML::Document]
    #
    # @return [Facility]
    def self.parse(url:, document:)
      data = parse_ld(document: document)
      id = parse_id(data: data)
      name = parse_name(document: document)
      address = Address.parse(data: data['address'])
      geocode = Geocode.parse(data: data['geo'])
      prices = parse_prices(document: document)

      new(id:, url:, name:, address:, geocode:, prices:)
    end

    # @param data [Hash]
    #
    # @return [Integer]
    def self.parse_id(data:)
      Integer(data['url'].match(ID_REGEX)[:id])
    end

    # @param document [NokoGiri::XML::Document]
    #
    # @return [String]
    def self.parse_name(document:)
      document.at_css(NAME_SELECTOR).text.gsub(/\s+/, ' ').strip
    end

    # @param docunent [NokoGiri::XML::Document]
    # @return Array<Price>
    def self.parse_prices(document:)
      document.css(PRICE_SELECTOR).map { |element| Price.parse(element:) }
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
    # @param url [String]
    # @param name [String]
    # @param address [Address]
    # @param geocode [Geocode]
    # @param prices [Array<Price>]
    def initialize(id:, url:, name:, address:, geocode:, phone: DEFAULT_PHONE, email: DEFAULT_EMAIL, prices: [])
      @id = id
      @url = url
      @name = name
      @address = address
      @geocode = geocode
      @phone = phone
      @email = email
      @prices = prices
    end

    # @return [String]
    def inspect
      props = [
        "id=#{@id.inspect}",
        "url=#{@url.inspect}",
        "address=#{@address.inspect}",
        "geocode=#{@geocode.inspect}",
        "phone=#{@phone.inspect}",
        "email=#{@email.inspect}",
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
