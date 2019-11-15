# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services ELB in Ireland.
class AwsElbIreland < AwsProvider
  def initialize
    super
    @name = 'AWS ELB (Ireland)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/elb-eu-west-1.rss')
  end
end
