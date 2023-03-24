#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'logger'
require 'rest-client'
require 'google/cloud/firestore'
require 'google/cloud/pubsub'

# Class that asks providers for their status updates and posts corresponding alerts to a specified Slack channel.
class CloudStatusAlerter
  DATE_TIME_FORMAT     = '%A %d %b %Y %H:%M:%S UTC'
  FIRESTORE_COLLECTION = 'cloud-status-alerter-updates'
  THREE_SECONDS        = 3

  def self.providers
    @providers ||= []
  end

  def self.register_provider(instance)
    providers << instance
  end

  def initialize
    @logger = Logger.new($stdout)
    initialize_firestore_client
    load_providers
  end

  def load_providers
    Dir['./providers/*.rb'].each do |file|
      require_relative file
      klass = self.class.const_get(File.basename(file).gsub('.rb', '').split('_').map(&:capitalize).join).to_s
      self.class.register_provider(Object.const_get(klass).new)
    end
  end

  def run
    self.class.providers.each do |provider|
      update = provider.latest_update
      next if update.nil?

      post_slack_message(provider.icon, provider.name, update) unless in_firestore?(provider, update)
      save_to_firestore(provider, update)
    end
  end

  private

  def firestore_key(provider, update)
    "#{FIRESTORE_COLLECTION}-#{provider.name.gsub(' ', '-').gsub(/\(|\)/, '').downcase}/#{update.id}"
  end

  def format_text(update)
    formatted_timestamp = DateTime.parse(update.timestamp).strftime(DATE_TIME_FORMAT)
    return "_Published #{formatted_timestamp}_\n\n#{update.text}\n\n#{update.uri}" if update.metadata.nil?

    "*#{update.metadata}*\n_Published #{formatted_timestamp}_\n\n#{update.text}\n\n#{update.uri}"
  end

  def in_firestore?(provider, update)
    doc = @firestore_client.doc(firestore_key(provider, update))
    snapshot = doc.get
    return false if snapshot.data.nil?

    snapshot[:timestamp].eql?(update.timestamp) && snapshot[:text].eql?(update.text)
  end

  def initialize_firestore_client
    firestore_project     = ENV['FIRESTORE_PROJECT']
    firestore_credentials = ENV['FIRESTORE_CREDENTIALS']
    raise 'Missing FIRESTORE_PROJECT environment variable' unless firestore_project

    Google::Cloud::Firestore.configure do |config|
      config.project_id  = firestore_project
      config.credentials = firestore_credentials if firestore_credentials
    end

    @firestore_client = Google::Cloud::Firestore.new
  end

  def post_slack_message(icon, username, update)
    text = format_text(update)
    payload = {
      'channel': ENV['STATUS_ALERTS_SLACK_CHANNEL'],
      'icon_emoji': ":#{icon}:",
      'username': "#{username} - Cloud Status Bot",
      'text': text,
      'attachments': []
    }.to_json.encode('UTF-8')
    headers = { 'Content-Type': 'application/json' }

    pubsub = Google::Cloud::PubSub.new

    topic = pubsub.topic "projects/#{ENV['MONITORING_PROJECT']}/topics/#{ENV['SLACK_PUBSUB_TOPIC']}"

    begin
      sleep THREE_SECONDS # Avoid Slack's rate limits.
      topic.publish_async payload do |result|
        raise "Failed to publish the message: #{result.error}" unless result.succeeded?
        @logger.info("#{username} message published successfully: #{result.data}")
      end

      # Stop the async_publisher to send all queued messages immediately.
      topic.async_publisher.stop.wait!
    end
  end

  def save_to_firestore(provider, update)
    doc = @firestore_client.doc(firestore_key(provider, update))
    doc.set({ timestamp: update.timestamp, text: update.text })
  end
end

CloudStatusAlerter.new.run