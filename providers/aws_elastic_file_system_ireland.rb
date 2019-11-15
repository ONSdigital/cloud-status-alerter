# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services Elastic File System in Ireland.
class AwsElasticFileSystemIreland < AwsProvider
  def initialize
    super
    @name = 'AWS Elastic File System (Ireland)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/elasticfilesystem-eu-west-1.rss')
  end
end
