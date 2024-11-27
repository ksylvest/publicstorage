# frozen_string_literal: true

RSpec.describe PublicStorage::Facility do
  describe '.sitemap' do
    subject(:sitemap) { described_class.sitemap }

    around { |example| VCR.use_cassette('publicstorage/facility/sitemap', &example) }

    it 'fetches and parses the sitemap' do
      expect(sitemap).to be_a(PublicStorage::Sitemap)
      expect(sitemap.links).to all(be_a(PublicStorage::Link))
    end
  end

  describe '.fetch' do
    subject(:fetch) { described_class.fetch(url: url) }

    let(:url) { 'https://www.publicstorage.com/self-storage-ca-los-angeles/2.html' }

    around { |example| VCR.use_cassette('publicstorage/facility/fetch', &example) }

    it 'fetches and parses the facility' do
      expect(fetch).to be_a(described_class)
      expect(fetch.address).to be_a(ExtraSpace::Address)
      expect(fetch.geocode).to be_a(ExtraSpace::Geocode)
      expect(fetch.prices).to all(be_a(ExtraSpace::Price))
    end
  end
end
