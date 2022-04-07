# frozen_string_literal: true

require 'feedjira'
require 'sanitize'
require_relative '../provider'

# Provider for Trello.
class Trello < Provider
  STATUS_FEED_URL = 'https://trello.status.atlassian.com/history.atom'

  def initialize
    super
    @icon = 'trello'
    @name = 'Trello'
  end

  def latest_update
    feed = Feedjira.parse(RestClient.get(STATUS_FEED_URL))
    raise "Unable to retrieve Atom feed from #{STATUS_FEED_URL}" unless feed
    return nil if feed.entries.empty?

    latest = feed.entries.first
    StatusFeedUpdate.new(id: latest.entry_id.partition('/').last,
                         timestamp: latest.published.to_datetime.to_s,
                         metadata: latest.title,
                         text: Sanitize.fragment(latest.content, whitespace_elements: WHITESPACE_ELEMENTS),
                         uri: latest.url)
  end
end
