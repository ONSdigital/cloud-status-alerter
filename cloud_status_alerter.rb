#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'logger'
require 'rest-client'
require 'google/cloud/firestore'

# Class that consumes the Google Cloud Status Dashboard JSON feed and posts corresponding alerts to a specified
# Slack channel.
class CloudStatusAlerter
  DATE_TIME_FORMAT     = '%A %d %b %Y %H:%M:%S UTC'
  FIRESTORE_COLLECTION = 'cloud-status-alerter-updates-test'
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
      klass = self.class.const_get(File.basename(file).gsub('.rb', '').split('_').map(&:capitalize).first).to_s
      self.class.register_provider(Object.const_get(klass).new)
    end
  end

  def run
    self.class.providers.each do |provider|
      update = provider.latest_update
      post_slack_message(provider.icon, provider.name, update) unless in_firestore?(provider, update)
      save_to_firestore(provider, update)
    end
  end

  private

  def format_text(update)
    formatted_timestamp = DateTime.parse(update.timestamp).strftime(DATE_TIME_FORMAT)
    return "#{formatted_timestamp}\n\n#{update.text}\n\n#{update.uri}" if update.metadata.nil?

    "*#{update.metadata}*\n#{formatted_timestamp}\n\n#{update.text}\n\n#{update.uri}"
  end

  def in_firestore?(provider, update)
    doc = @firestore_client.doc("#{FIRESTORE_COLLECTION}#{provider.name}/#{update.id}")
    snapshot = doc.get
    return false if snapshot.data.nil?

    snapshot[:timestamp].eql?(update.timestamp) && snapshot[:text].eql?(update.text)
  end

  def initialize_firestore_client
    firestore_project     = ENV['FIRESTORE_PROJECT']
    firestore_credentials = ENV['FIRESTORE_CREDENTIALS']
    raise 'Missing FIRESTORE_PROJECT environment variable' unless firestore_project
    raise 'Missing FIRESTORE_CREDENTIALS environment variable' unless firestore_credentials

    Google::Cloud::Firestore.configure do |config|
      config.project_id  = firestore_project
      config.credentials = firestore_credentials
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
    begin
      sleep THREE_SECONDS # Avoid Slack's rate limits.
      RestClient.post(ENV['SLACK_WEBHOOK'].chomp, payload, headers)
      @logger.info text
    rescue RestClient::ExceptionWithResponse => e
      @logger.error("Error posting to Slack: HTTP #{e.response.code} #{e.response}")
    end
  end

  def save_to_firestore(provider, update)
    doc = @firestore_client.doc("#{FIRESTORE_COLLECTION}#{provider.name}/#{update.id}")
    doc.set(timestamp: update.timestamp, text: update.text)
  end
end

CloudStatusAlerter.new.run
