# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services CloudWatch in London.
class AwsCloudWatchLondon < AwsProvider
  def initialize
    super
    @name = 'AWS CloudWatch (London)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/cloudwatch-eu-west-2.rss')
  end
end
