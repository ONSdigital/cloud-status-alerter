# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services S3 in London.
class AwsS3London < AwsProvider
  def initialize
    super
    @name = 'AWS S3 (London)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/s3-eu-west-2.rss')
  end
end
