# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services Elastic File System in London.
class AwsElasticFileSystemLondon < AwsProvider
  def initialize
    super
    @name = 'AWS Elastic File System (London)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/elasticfilesystem-eu-west-2.rss')
  end
end
