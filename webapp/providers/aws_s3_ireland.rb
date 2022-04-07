# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services S3 in Ireland.
class AwsS3Ireland < AwsProvider
  def initialize
    super
    @name = 'AWS S3 (Ireland)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/s3-eu-west-1.rss')
  end
end
