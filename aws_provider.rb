# frozen_string_literal: true

require 'feedjira'
require_relative 'provider'

# Base class for Amazon Web Services providers.
class AwsProvider < Provider
  def initialize
    @icon = 'aws'
  end

  def latest_update(status_feed_url)
    feed = Feedjira.parse(RestClient.get(status_feed_url))
    raise "Unable to retrieve RSS feed from #{status_feed_url}" unless feed
    return nil if feed.entries.empty?

    latest = feed.entries.first
    StatusFeedUpdate.new(id: latest.entry_id.partition('#').last,
                         timestamp: latest.published.to_datetime.to_s,
                         metadata: latest.title,
                         text: latest.summary,
                         uri: latest.url)
  end
end
