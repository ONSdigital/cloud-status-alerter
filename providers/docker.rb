# frozen_string_literal: true

require 'feedjira'
require 'sanitize'
require_relative '../provider'

# Provider for Docker Hub.
class Docker < Provider
  STATUS_FEED_URL = 'https://status.docker.com/pages/533c6539221ae15e3f000031/rss'

  def initialize
    @icon = 'docker'
    @name = 'Docker Hub'
  end

  def latest_update
    feed = Feedjira.parse(RestClient.get(STATUS_FEED_URL))
    raise "Unable to retrieve RSS feed from #{STATUS_FEED_URL}" unless feed
    return nil if feed.entries.empty?

    latest = feed.entries.first
    StatusFeedUpdate.new(id: latest.entry_id,
                         timestamp: latest.published.to_datetime.to_s,
                         metadata: latest.title,
                         text: Sanitize.fragment(latest.summary, whitespace_elements: WHITESPACE_ELEMENTS),
                         uri: latest.url)
  end
end
