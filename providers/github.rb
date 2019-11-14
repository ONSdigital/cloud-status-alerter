# frozen_string_literal: true

require 'feedjira'
require 'json'
require 'sanitize'
require_relative '../provider'

# Provider for GitHub.
class Github < Provider
  STATUS_FEED_URL = 'https://www.githubstatus.com/history.atom'

  def initialize
    @icon = 'github'
    @name = 'GitHub'
  end

  def latest_update
    feed = Feedjira.parse(RestClient.get(STATUS_FEED_URL))
    raise "Unable to retrieve Atom feed from #{STATUS_FEED_URL}" unless feed

    latest = feed.entries.first
    StatusFeedUpdate.new(id: latest.entry_id.partition('/').last,
                         timestamp: latest.published.to_datetime.to_s,
                         metadata: nil,
                         text: Sanitize.fragment(latest.content, whitespace_elements: WHITESPACE_ELEMENTS),
                         uri: latest.url)
  end
end
