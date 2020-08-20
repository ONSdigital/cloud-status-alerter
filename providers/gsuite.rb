# frozen_string_literal: true

require 'feedjira'
require 'sanitize'
require 'securerandom'
require_relative '../provider'

# Provider for G Suite.
class Gsuite < Provider
  STATUS_FEED_URL = 'https://www.google.co.uk/appsstatus/rss/en'
  SERVICES_OF_INTEREST = ['Admin console',
                          'Google Analytics',
                          'Google Docs',
                          'Google Drive',
                          'Google Maps',
                          'Google Meet',
                          'Google Sheets'].freeze

  def initialize
    @icon = 'google'
    @name = 'G Suite'
  end

  def latest_update
    feed = Feedjira.parse(RestClient.get(STATUS_FEED_URL))
    raise "Unable to retrieve RSS feed from #{STATUS_FEED_URL}" unless feed
    return nil if feed.entries.empty?

    latest = feed.entries.first
    service_name = latest['title']
    return unless SERVICES_OF_INTEREST.include?(service_name)

    StatusFeedUpdate.new(id: SecureRandom.random_number(10**10).to_s.rjust(10, '0'), # Have to generate an ID because the RSS feed doesn't include unique ones.
                         timestamp: latest.pubDate.to_datetime.to_s,
                         metadata: latest.title,
                         text: Sanitize.fragment(latest.description, whitespace_elements: WHITESPACE_ELEMENTS),
                         uri: latest.link)
  end
end
