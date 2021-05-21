# frozen_string_literal: true

require 'json'
require_relative '../provider'

# Provider for Google Cloud Platform.
class Gcp < Provider
  STATUS_FEED_URL      = 'https://status.cloud.google.com/incidents.json'
  URI_ROOT             = 'https://status.cloud.google.com/'
  SERVICES_OF_INTEREST = ['Cloud Developer Tools',
                          'Cloud Filestore',
                          'Cloud Firestore',
                          'Cloud Key Management Service',
                          'Cloud Memorystore',
                          'Cloud Security Command Center',
                          'Cloud Spanner',
                          'Google App Engine',
                          'Google BigQuery',
                          'Google Cloud Bigtable',
                          'Google Cloud Console',
                          'Google Cloud Datastore',
                          'Google Cloud DNS',
                          'Google Cloud Functions',
                          'Google Cloud Infrastructure Components',
                          'Google Cloud Networking',
                          'Google Cloud Pub/Sub',
                          'Google Cloud Scheduler',
                          'Google Cloud SQL',
                          'Google Cloud Storage',
                          'Google Cloud Support',
                          'Google Compute Engine',
                          'Google Kubernetes Engine',
                          'Google Stackdriver',
                          'Identity and Access Management'].freeze

  def initialize
    @icon = 'gcp'
    @name = 'GCP'
  end

  def latest_update
    json = JSON.parse(RestClient.get(STATUS_FEED_URL))
    raise "Unable to retrieve JSON feed from #{STATUS_FEED_URL}" unless json

    latest = json.first
    service_name = latest['service_name']
    return unless SERVICES_OF_INTEREST.include?(service_name)

    StatusFeedUpdate.new(id: latest['number'],
                         timestamp: DateTime.rfc3339(latest['most_recent_update']['when']).to_s,
                         metadata: service_name,
                         text: latest['most_recent_update']['text'],
                         uri: "#{URI_ROOT}#{latest['uri']}")
  end
end
