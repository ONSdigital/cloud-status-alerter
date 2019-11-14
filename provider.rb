# frozen_string_literal: true

require 'date'
require 'rest-client'

# Base class that defines a common interface for all providers.
class Provider
  WHITESPACE_ELEMENTS = {
    'b' => { before: '*', after: '*' },
    'br' => { before: "\n", after: '' },
    'p' => { before: "\n", after: "\n" },
    'strong' => { before: '*', after: '*' }
  }.freeze

  attr_reader :icon, :name

  StatusFeedUpdate = Struct.new(:id, :timestamp, :metadata, :text, :uri, keyword_init: true)
end
