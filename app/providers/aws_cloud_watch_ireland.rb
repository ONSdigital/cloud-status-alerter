# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services CloudWatch in Ireland.
class AwsCloudWatchIreland < AwsProvider
  def initialize
    super
    @name = 'AWS CloudWatch (Ireland)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/cloudwatch-eu-west-1.rss')
  end
end
