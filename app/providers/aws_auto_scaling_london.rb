# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services Auto Scaling in London.
class AwsAutoScalingLondon < AwsProvider
  def initialize
    super
    @name = 'AWS Auto Scaling (London)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/autoscaling-eu-west-2.rss')
  end
end
