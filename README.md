# Public Storage

[![LICENSE](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/ksylvest/publicstorage/blob/main/LICENSE)
[![RubyGems](https://img.shields.io/gem/v/publicstorage)](https://rubygems.org/gems/publicstorage)
[![GitHub](https://img.shields.io/badge/github-repo-blue.svg)](https://github.com/ksylvest/publicstorage)
[![Yard](https://img.shields.io/badge/docs-site-blue.svg)](https://publicstorage.ksylvest.com)
[![CircleCI](https://img.shields.io/circleci/build/github/ksylvest/publicstorage)](https://circleci.com/gh/ksylvest/publicstorage)

A Ruby library offering both a CLI and API for scraping [Public Storage](https://www.publicstorage.com/) self-storage facilities and prices.

## Installation

```bash
gem install publicstorage
```

## Configuration

```ruby
require 'publicstorage'

PublicStorage.configure do |config|
  config.user_agent = '../..' # ENV['PUBLICSTORAGE_USER_AGENT']
  config.timeout = 30 # ENV['PUBLICSTORAGE_TIMEOUT']
end
```

## Usage

```ruby
require 'publicstorage'

sitemap = PublicStorage::Facility.sitemap
sitemap.links.each do |link|
  url = link.loc
  facility = PublicStorage::Facility.fetch(url:)

  puts facility.text

  facility.prices.each do |price|
    puts price.text
  end

  puts
end
```

## CLI

```bash
publicstorage crawl
```

```bash
publicstorage crawl "https://www.publicstorage.com/self-storage-ca-venice/120.html"
```
