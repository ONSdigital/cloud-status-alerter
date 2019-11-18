# frozen_string_literal: true

require 'feedjira'
require 'sanitize'
require_relative '../provider'

# Provider for Slack.
class Slack < Provider
  STATUS_FEED_URL = 'https://status.slack.com/feed/atom'

  def initialize
    @icon = 'slack'
    @name = 'Slack'
  end

  def latest_update
    feed = Feedjira.parse(RestClient.get(STATUS_FEED_URL))
    raise "Unable to retrieve Atom feed from #{STATUS_FEED_URL}" unless feed
    return nil if feed.entries.empty?

    latest = feed.entries.first
    StatusFeedUpdate.new(id: latest.entry_id.scan(/[\w]+$/).last,
                         timestamp: latest.published.to_datetime.to_s,
                         metadata: latest.title,
                         text: Sanitize.fragment(latest.content, whitespace_elements: WHITESPACE_ELEMENTS),
                         uri: latest.url)
  end
end
