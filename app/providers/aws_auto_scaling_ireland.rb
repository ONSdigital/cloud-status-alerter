# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services Auto Scaling in Ireland.
class AwsAutoScalingIreland < AwsProvider
  def initialize
    super
    @name = 'AWS Auto Scaling (Ireland)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/autoscaling-eu-west-1.rss')
  end
end
