# PublicStorage

[![LICENSE](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/ksylvest/publicstorage/blob/main/LICENSE)
[![RubyGems](https://img.shields.io/gem/v/publicstorage)](https://rubygems.org/gems/publicstorage)
[![GitHub](https://img.shields.io/badge/github-repo-blue.svg)](https://github.com/ksylvest/publicstorage)
[![Yard](https://img.shields.io/badge/docs-site-blue.svg)](https://publicstorage.ksylvest.com)
[![CircleCI](https://img.shields.io/circleci/build/github/ksylvest/publicstorage)](https://circleci.com/gh/ksylvest/publicstorage)

## Installation

```bash
gem install publicstorage
```

## Usage

```ruby
require 'publicstorage'

sitemap = PublicStorage::Facility.sitemap
sitemap.links.each do |link|
  url = link.loc

  facility = PublicStorage::Facility.fetch(url:)

  puts "Street: #{facility.address.street}"
  puts "City: #{facility.address.city}"
  puts "State: #{facility.address.state}"
  puts "ZIP: #{facility.address.zip}"
  puts "Latitude: #{facility.geocode.latitude}"
  puts "Longitude: #{facility.geocode.longitude}"
  puts

  facility.prices.each do |price|
    puts "ID: #{price.id}"
    puts "Width: #{price.dimensions.width}"
    puts "Depth: #{price.dimensions.depth}"
    puts "SQFT: #{price.dimensions.sqft}"
    puts "Rates: $#{price.rates.street} (street) / $#{price.rates.web} (web)"
    puts
  end
end
```
