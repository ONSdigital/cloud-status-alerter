# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services ELB in London.
class AwsElbLondon < AwsProvider
  def initialize
    super
    @name = 'AWS ELB (London)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/elb-eu-west-2.rss')
  end
end
